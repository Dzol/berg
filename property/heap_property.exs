defmodule HeapProperty do
  use ExUnit.Case
  use PropCheck

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

  ## Ancillary

  defp heapify(x), do: heapify(x, Heap.zero())

  defp heapify([], z) do
    z
  end
  defp heapify([x|y], z) do
    heapify(y, Heap.insert(z, x))
  end

  defp listify(x), do: listify(x, [])

  defp listify(x, y) do
    if Heap.zero?(x) do
      Enum.reverse(y)
    else
      {i, j} = Heap.extract(x)
      listify(i, [j|y])
    end
  end
end
