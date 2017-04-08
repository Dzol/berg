defmodule HeapProperty do
  use ExUnit.Case
  use PropCheck

  property "first element of heap is the minimum of its input" do
    forall x <- list(integer()) do
      implies x != [] do
        assert List.first(listify(heapify(x))) === Enum.min(x)
      end
    end
  end

  property "last element of heap is the maximum of its input" do
    forall x <- list(integer()) do
      implies x != [] do
        assert length(listify(heapify(x))) == length(x)
      end
    end
  end

  property "heap has as many elements as its input" do
    forall x <- list(integer()) do
      implies x != [] do
        assert length(listify(heapify(x))) == length(x)
      end
    end
  end

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
