defmodule Parker.Queue do
  @moduledoc """
  Wraps Erlang [pqueue](https://github.com/okeuday/pqueue) module
  """

  alias Parker.{Element, Queue}

  @modules [:pqueue, :pqueue2, :pqueue3, :pqueue4]

  @type t :: %Queue{
    module: atom,
    data: list(Element),
  }
  @enforce_keys [:module, :data]
  defstruct [
    :module,
    :data,
   ]

  @doc """
  Returns a new empty Queue using the specified module
  modules can be [:pqueue, :pqueue2, :pqueue3, :pqueue4]
  """
  @spec init(atom) :: Queue.t
  def init(module \\ :pqueue2) when module in @modules do
    %Queue{
      module: module,
      data: module.new,
    }
  end

  @doc """
  Puts an Element in the priority Queuewith Element.priority, returns Queue with the new Element in.
  """
  @spec put(Queue.t, Element.t) :: Queue.t
  def put(%Queue{module: module, data: data} = queue, %Element{priority: priority} = element) do
    data = element |> module.in(priority(queue, priority), data)
    %Queue{queue | data: data}
  end

  @doc """
  Returns next element from the Queue.
  """
  @spec pull(Queue.t) :: Element.t
  def pull(%Queue{module: module, data: data} = queue) do
    {{_, element}, data} = module.out(data)
    {%Queue{queue | data: data}, element}
  end

  @doc """
  Takes demand Elements from Queue.
  """
  @spec take(Queue.t, integer) :: list(Element.t)
  def take(queue, demand) do
    Enum.take(queue.module.to_list(queue.data), demand)
  end

  @spec priority(Queue.t, integer) :: integer
  defp priority(%Queue{module: :pqueue2}, priority), do: -priority
  defp priority(%Queue{module: :pqueue3}, priority), do: -priority
end
