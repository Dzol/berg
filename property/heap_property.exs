defmodule HeapProperty do
  use ExUnit.Case
  use PropCheck
  import Heap, only: [heapify: 1, listify: 1]

  property "first element out is the smallest" do
    forall x <- list(integer()) do
      implies x != [] do

        assert List.first(listify(heapify(x))) === Enum.min(x)
      end
    end
  end

  property "last element out is the biggest" do
    forall x <- list(integer()) do
      implies x != [] do

        assert List.last(listify(heapify(x))) == Enum.max(x)
      end
    end
  end

  property "as many elements out as put in" do
    forall x <- list(integer()) do
      implies x != [] do

        assert length(listify(heapify(x))) == length(x)
      end
    end
  end

  property "same elements out as put in" do
    forall x <- list(integer()) do
      implies x != [] do

        assert Enum.all?(listify(heapify(x)), &Enum.member?(x, &1))
      end
    end
  end

  ## Property around the minima and maxima when we arbitrarily
  ## interleave insertion and extraction
end
