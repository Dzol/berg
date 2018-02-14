defmodule BergProperty do
  use ExUnit.Case
  import PropertyTest
  import Berg, only: [heapify: 1, listify: 1]

  property "first element out is the smallest in" do
    check all input <- list_of(integer(), min_length: 1) do
      out = input |> heapify() |> listify()

      assert List.first(out) === Enum.min(input)
    end
  end

  property "last element out is the biggest in" do
    check all input <- list_of(integer(), min_length: 1) do
      out = input |> heapify() |> listify()

      assert List.last(out) == Enum.max(input)
    end
  end

  property "as many elements out as put in" do
    check all input <- list_of(integer(), min_length: 1) do
      out = input |> heapify() |> listify()

      assert length(out) == length(input)
    end
  end

  property "output values ⊆ input values" do
    check all input <- list_of(integer(), min_length: 1) do
      out = input |> heapify() |> listify()

      assert Enum.all?(out, &Enum.member?(input, &1))
    end
  end

  property "output values ⊇ input values" do
    check all input <- list_of(integer(), min_length: 1) do
      out = input |> heapify() |> listify()

      assert Enum.all?(input, &Enum.member?(out, &1))
    end
  end

  ## Property around the minima and maxima when we arbitrarily
  ## interleave insertion and extraction
end
