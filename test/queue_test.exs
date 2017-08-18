defmodule ParkerTest.Queue do
  use ExUnit.Case
  alias Parker.{Queue, Element}

  describe "when initializing" do
    test "with specific modules" do
      Enum.each([:pqueue, :pqueue2, :pqueue3, :pqueue4], fn(name) ->
        queue = Queue.init(name)
        assert queue.module == name
        assert queue.data == name.new()
      end)
    end

    test "with known modules" do
      assert_raise FunctionClauseError, ~r/no function clause matching/,
        fn -> Queue.init(:madeup) end
    end

    test "with :pqueue2 as default" do
      queue = Queue.init
      assert queue.module == :pqueue2
    end
  end

  describe "when manipulating" do
    setup do
      %{queue: Queue.init}
    end

    test "can put and pull a Parker.Element", %{queue: queue} do
      element_in = %Element{uid: 'test', priority: 10}
      queue = Queue.put(queue, element_in)
      {_, element_out} = Queue.pull(queue)
      assert element_in == element_out
    end

    test "can put and pull several Parker.Element(s) with a priority", %{queue: queue} do
      element1 = %Element{uid: 'test1', priority: 10}
      element2 = %Element{uid: 'test2', priority: 11}
      element3 = %Element{uid: 'test3', priority: 9}
      queue = Enum.reduce([element1, element2, element3],
                queue, fn(e, q) -> Queue.put(q, e) end)
      assert [element2, element1, element3] == Queue.take(queue, 3)
    end
  end
end
