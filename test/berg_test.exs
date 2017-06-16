defmodule BergTest do
  use ExUnit.Case
  doctest Berg

  test "the zero heap predicate" do

    assert true  == Berg.zero?(Berg.zero())
    assert false == Berg.zero?(Berg.zero()   |> Berg.insert(0))
    assert false == Berg.zero?(Berg.unary(0))
    assert false == Berg.zero?(Berg.unary(0) |> Berg.insert(1))
  end

  test "peeking at the heap" do

    assert 0 == Berg.root(Berg.zero()   |> Berg.insert(0))
    assert 0 == Berg.root(Berg.unary(0))
    assert 0 == Berg.root(Berg.unary(0) |> Berg.insert(1))
  end

  test "duplicate element present" do

    x = Berg.zero() |> Berg.insert(0) |> Berg.insert(0)

    assert {y, 0} = Berg.extract(x)
    assert {z, 0} = Berg.extract(y)

    assert Berg.zero?(z) == true
  end

  test "insert string element failure" do

    assert_raise FunctionClauseError, fn ->
      Berg.insert(Berg.zero(), "fu")
    end
  end
end
