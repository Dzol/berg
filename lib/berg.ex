defmodule Berg.Heap do
  @moduledoc """
  A Minimum Heap for Integers

  ![The Tatra Range](./tatra.jpg)

  <p>
    <cite>The Tatra Range:</cite> TripAdvisor
  </p>
  """

  defmodule Element do
    @moduledoc """
    Heap element dialyzer declaration
    """

    @typedoc """
    An Element (just an Integer)
    """
    @type t :: integer
  end

  @typedoc """
  A Minimum Heap (of Integers)
  """
  @opaque t :: {
    value    :: :infinity | Element.t,
    children :: list
  }

  @doc """
  A _zero_ heap
  """
  @spec zero :: __MODULE__.t
  def zero do
    :heap.zero()
  end

  @doc """
  Predicate: is this the _zero_ heap?

  ## Example

      iex> alias Berg.Heap
      iex> Heap.zero?(Heap.zero())
      true

  """
  @spec zero?(__MODULE__.t) :: boolean
  def zero?(x) do
    :heap.zero(x)
  end

  @doc """
  A Heap w/ just one element

  ## Example

      iex> alias Berg.Heap
      iex> Heap.zero?(Heap.unary(4))
      false

  """
  @spec unary(Element.t) :: __MODULE__.t
  def unary(x) do
    :heap.unary(x)
  end

  @doc """
  The smallest element of the heap

  ## Example

      iex> alias Berg.Heap
      iex> l = [42, 16, 8, 4, 15, 23]
      iex> h = Heap.heapify(l)
      iex> Heap.root(h)
      4

  """
  @spec root(__MODULE__.t) :: Element.t
  def root(x) do
    :heap.peak(x)
  end

  @doc """
  A heap whose smallest element is the minimum of the element in
  question and the smallest element of the heap in question

  ## Example

      iex> alias Berg.Heap
      iex> l = [16, 8, 15, 23]
      iex> h = Heap.heapify(l)
      iex> i = h |> Heap.insert(4) |> Heap.insert(42)
      iex> Heap.root(i)
      4

  """
  @spec insert(__MODULE__.t, Element.t) :: __MODULE__.t
  def insert(x, y) do
    :heap.insert(y, x)
  end

  @doc """
  The heap in question w/o the smallest element

  ## Example

      iex> alias Berg.Heap
      iex> l = [42, 16, 8, 4, 15, 23]
      iex> h = Heap.heapify(l)
      iex> t = Heap.trunk(h)
      iex> Heap.listify(t)
      [8, 15, 16, 23, 42]

  """
  @spec trunk(__MODULE__.t) :: __MODULE__.t
  def trunk(x) do
    elem(extract(x), 0)
  end

  @doc """
  A heap alongside an element where that element would be the smallest
  if it were in the heap

  ## Example

      iex> alias Berg.Heap
      iex> l = [42, 16, 8, 4, 15, 23]
      iex> h = Heap.heapify(l)
      iex> {t, e} = Heap.extract(h)
      iex> Heap.listify(t)
      [8, 15, 16, 23, 42]
      iex> e
      4

  """
  @spec extract(__MODULE__.t) :: {__MODULE__.t, Element.t}
  def extract(x) do
    :heap.extract(x)
  end

  @doc """
  A heap with the same elements as the list in question
  """
  @spec heapify(list(Element.t)) :: __MODULE__.t
  def heapify(x), do: heapify(x, zero())

  @spec heapify(list(Element.t), __MODULE__.t) :: __MODULE__.t
  defp heapify([], z) do
    z
  end
  defp heapify([x|y], z) do
    heapify(y, insert(z, x))
  end

  @doc """
  A list in ascending order (w/ all the same elements as the heap)
  """
  @spec listify(__MODULE__.t) :: list(Element.t)
  def listify(x), do: fold(x, [], & [&1 | &2])

  @doc """
  A fold such that successive elements are in ascending order
  """
  @spec fold(__MODULE__.t, term, (Element.t, term -> term)) :: term
  def fold(x, i, f) do ## Don't leak internals
    if zero?(x) do
      Enum.reverse(i)
    else
      fold(trunk(x), apply(f, [root(x), i]), f)
    end
  end
end
