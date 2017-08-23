defmodule Parker.State do
  @moduledoc """
  Keeps the state of pending, current, done resources.
  """
  alias Parker.{State, Queue, Element}

  @typedoc """
  The `Parker.State` struct type.
  Fields' meaning:
  - `:pending` - resources to fetch
  - `:doing` - resources Parker is currently working on
  - `:done` - resources already worked
  - `:errors` - errors
  """
  @type t :: %State{
    pending: Queue.t,
    doing: MapSet.t,
    done: MapSet.t,
    errors: MapSet.t,
  }
  @enforce_keys [:pending]
  defstruct [
    :pending,
    doing: [],
    done: [],
    errors: [],
  ]

  @doc """
  Returns a new State data structure
  """
  @spec init(:atom, Enum.t) :: State.t
  def init(module \\ nil, uids \\ []) do
    module |> Queue.init |> _init(uids)
  end

  defp _init(queue, uids) do
    queue =
      case Enum.empty?(uids) do
        true  -> queue
        false -> uids |> Enum.reduce(queue, fn(uid, q) -> Queue.put(q, %Element{uid: uid, priority: 1}) end)
      end
    %State{pending: queue}
  end
end
