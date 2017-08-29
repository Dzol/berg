defmodule BergProperty do
  use ExUnit.Case
  import PropertyTest
  import Berg, only: [heapify: 1, listify: 1]

  property "first element out is the smallest in" do
    check all x <- list_of(integer()), x != [] do
      y = x |> heapify() |> listify()

      assert List.first(y) === Enum.min(x)
    end
  end

  property "last element out is the biggest in" do
    check all x <- list_of(integer()), x != [] do
      y = x |> heapify() |> listify()

      assert List.last(y) == Enum.max(x)
    end
  end

  property "as many elements out as put in" do
    check all x <- list_of(integer()), x != [] do
      y = x |> heapify() |> listify()

      assert length(y) == length(x)
    end
  end

  property "output values ⊆ input values" do
    check all x <- list_of(integer()), x != [] do
      y = x |> heapify() |> listify()

      assert Enum.all?(y, &Enum.member?(x, &1))
    end
  end

  property "input values ⊆ output values" do
    check all x <- list_of(integer()), x != [] do
      y = x |> heapify() |> listify()

      assert Enum.all?(x, &Enum.member?(y, &1))
    end
  end

  ## Property around the minima and maxima when we arbitrarily
  ## interleave insertion and extraction
end
