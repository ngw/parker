defmodule Parker.Fetcher do
  @moduledoc ~S"""
  A Producer that grabs *elements and passes them along the pipeline.
  Can use many Adapters that can fetch from many sources returning always
  an *array of elements.
  """
  use GenStage

  def init(targets: targets, adapter: adapter) do
    {:producer, targets: targets, adapter: adapter}
  end

  def handle_demand(demand, [targets: targets, adapter: adapter]) do
    {to_process, remaining} = targets |> Enum.split(demand)
    elements = Enum.map(to_process, fn(target) -> adapter.get(target) end)
    {:noreply, elements, remaining}
  end
end
