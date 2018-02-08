defmodule Berg.HeapTest do
  use ExUnit.Case
  doctest Berg.Heap

  test "the zero heap predicate" do
    alias Berg.Heap

    assert true  == Heap.zero?(Heap.zero())
    assert false == Heap.zero?(Heap.zero()   |> Heap.insert(0))
    assert false == Heap.zero?(Heap.unary(0))
    assert false == Heap.zero?(Heap.unary(0) |> Heap.insert(1))
  end

  test "peeking at the heap" do
    alias Berg.Heap

    assert 0 == Heap.root(Heap.zero()   |> Heap.insert(0))
    assert 0 == Heap.root(Heap.unary(0))
    assert 0 == Heap.root(Heap.unary(0) |> Heap.insert(1))
  end

  test "duplicate element present" do
    alias Berg.Heap

    x = Heap.zero() |> Heap.insert(0) |> Heap.insert(0)

    assert {y, 0} = Heap.extract(x)
    assert {z, 0} = Heap.extract(y)

    assert Heap.zero?(z) == true
  end

  test "insert string element failure" do
    alias Berg.Heap

    assert_raise FunctionClauseError, fn ->
      Heap.insert(Heap.zero(), "fu")
    end
  end
end
