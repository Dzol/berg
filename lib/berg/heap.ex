defmodule Berg.Heap do
  @moduledoc """
  Find primitives in this module
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
  @opaque t :: [] | {
    value    :: Element.t,
    children :: list(t)
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

      iex> alias Berg
      iex> alias Berg.Heap
      iex> l = [42, 16, 8, 4, 15, 23]
      iex> h = Berg.heapify(l)
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

      iex> alias Berg
      iex> alias Berg.Heap
      iex> l = [16, 8, 15, 23]
      iex> h = Berg.heapify(l)
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

      iex> alias Berg
      iex> alias Berg.Heap
      iex> l = [42, 16, 8, 4, 15, 23]
      iex> h = Berg.heapify(l)
      iex> t = Heap.trunk(h)
      iex> Berg.listify(t)
      [8, 15, 16, 23, 42]

  """
  @spec trunk(__MODULE__.t) :: __MODULE__.t
  def trunk(x) do
    Map.get(extract(x), :heap)
  end

  @doc """
  A heap alongside an element where that element would be the smallest
  if it were in the heap

  ## Example

      iex> alias Berg
      iex> alias Berg.Heap
      iex> l = [42, 16, 8, 4, 15, 23]
      iex> h = Berg.heapify(l)
      iex> x = Heap.extract(h)
      iex> Berg.listify(x.heap)
      [8, 15, 16, 23, 42]
      iex> x.element
      4

  """
  @spec extract(__MODULE__.t) :: %{heap: __MODULE__.t, element: any()}
  def extract(x) do
    :heap.extract(x)
  end
end
