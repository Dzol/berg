defmodule Berg do
  @moduledoc """
  A Minimum Heap for Integers

  ![The Tatra Range](./tatra.jpg)

  <p>
  <cite>The Tatra Range:</cite> TripAdvisor
  </p>

  Find higher-order and conversion functions in this module.
  """

  alias Berg.Heap

  @doc """
  A heap with the same elements as the list in question
  """
  @spec heapify(list(Heap.Element.t)) :: Heap.t
  def heapify(x) do
    import Heap, only: [zero: 0]
    Enum.reduce(x, zero(), &heapify/2)
  end

  @spec heapify(Heap.Element.t, Heap.t) :: Heap.t
  def heapify(e, h) do
    import Berg.Heap, only: [insert: 2]
    insert(h, e)
  end

  @doc """
  A list in ascending order (w/ all the same elements as the heap)
  """
  @spec listify(Heap.t) :: list(Heap.Element.t)
  def listify(x) do
    x
    |> fold([], & [&1 | &2])
    |> Enum.reverse()
  end

  @doc """
  A fold such that successive elements are in ascending order
  """
  @spec fold(Heap.t, term, (Heap.Element.t, term -> term)) :: term
  def fold(x, i, f) do ## Don't leak internals
    import Berg.Heap, only: [zero?: 1, trunk: 1, root: 1]

    if zero?(x) do
      i
    else
      fold(trunk(x), apply(f, [root(x), i]), f)
    end
  end

  @doc """
  A (simple) map _from_ a heap _to_ a heap
  """
  @spec map(Heap.t, (Heap.Element.t -> Heap.Element.t)) :: Heap.t
  def map(x, f) do
    g = fn (e, a) ->
      Heap.insert(a, apply(f, [e]))
    end
    fold(x, Heap.zero(), g)
  end
end
