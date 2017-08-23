defmodule ParkerTest.State do
  use ExUnit.Case
  alias Parker.{State, Queue, Element}

  describe "when initializing" do
    test "with no args" do
      state = State.init
      assert state.pending == Queue.init
    end

    test "with a different pqueue module" do
      Enum.each([:pqueue, :pqueue2, :pqueue3, :pqueue4], fn(name) ->
        state = State.init(name)
        assert state.pending.module == name
      end)
    end

    test "with pending resources" do
      state = State.init(nil, ["test_element_1", "test_element_2"])
      q = state.pending
      assert {q, %Element{uid: "test_element_1"}} = Queue.pull(q)
      assert {_q, %Element{uid: "test_element_2"}} = Queue.pull(q)
    end
  end
end
