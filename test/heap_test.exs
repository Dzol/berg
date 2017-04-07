defmodule HeapTest do
  use ExUnit.Case

  test "the zero heap predicate" do

    assert true  == Heap.zero?(Heap.zero())
    assert false == Heap.zero?(Heap.zero()   |> Heap.insert(0))
    assert false == Heap.zero?(Heap.unary(0))
    assert false == Heap.zero?(Heap.unary(0) |> Heap.insert(1))
  end

  test "peak at the heap" do

    assert 0 == Heap.peak(Heap.zero()   |> Heap.insert(0))
    assert 0 == Heap.peak(Heap.unary(0))
    assert 0 == Heap.peak(Heap.unary(0) |> Heap.insert(1))
  end

  test "duplicate element present" do

    x = Heap.zero() |> Heap.insert(0) |> Heap.insert(0)

    assert {y, 0} = Heap.extract(x)
    assert {z, 0} = Heap.extract(y)

    assert Heap.zero?(z) == true
  end

  test "insert string element failure" do

    assert_raise FunctionClauseError, fn ->
      Heap.insert(Heap.zero(), "fu")
    end
  end
end
