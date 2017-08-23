defmodule BergProperty do
  use ExUnit.Case
  import PropertyTest
  import Berg, only: [heapify: 1, listify: 1]

  property "first element out is the smallest" do
    check all x <- list_of(integer()), x != [] do

      assert List.first(listify(heapify(x))) === Enum.min(x)
    end
  end

  property "last element out is the biggest" do
    check all x <- list_of(integer()), x != [] do

      assert List.last(listify(heapify(x))) == Enum.max(x)
    end
  end

  property "as many elements out as put in" do
    check all x <- list_of(integer()), x != [] do

      assert length(listify(heapify(x))) == length(x)
    end
  end

  property "same elements out as put in" do
    check all x <- list_of(integer()), x != [] do

      assert Enum.all?(listify(heapify(x)), &Enum.member?(x, &1))
    end
  end

  ## Property around the minima and maxima when we arbitrarily
  ## interleave insertion and extraction
end
