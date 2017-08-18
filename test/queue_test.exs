defmodule ParkerTest.Queue do
  use ExUnit.Case
  alias Parker.{Queue, Element}

  test "initialise a priority queue" do
    Enum.each([:pqueue, :pqueue2, :pqueue3, :pqueue4], fn(name) ->
      queue = Queue.init(name)
      assert queue.module == name
      assert queue.data == name.new()
    end)
  end

  test "doesn't initialise a priority queue when module is unknown" do
    assert_raise FunctionClauseError, ~r/no function clause matching/,
      fn -> Queue.init(:madeup) end
  end

  test "has :pqueue2 as default" do
    queue = Queue.init
    assert queue.module == :pqueue2
  end
end
