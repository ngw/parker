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
end
