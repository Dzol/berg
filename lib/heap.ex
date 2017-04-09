defmodule Heap do
  @moduledoc """
  A Minimum Heap for Integers
  """

  @typedoc """
  A Minimum Heap
  """
  @opaque t :: {
    value    :: :infinity | integer,
    children :: list
  }
  @typedoc """
  An Element (just an Integer)
  """
  @type element :: integer

  @doc """
  A _zero_ heap
  """
  @spec zero :: __MODULE__.t
  def zero do
    :heap.zero
  end

  @doc """
  Predicate: is this the _zero_ heap?
  """
  @spec zero?(__MODULE__.t) :: boolean
  def zero?(x) do
    :heap.zero(x)
  end

  @doc """
  A Heap w/ just one element
  """
  @spec unary(element) :: __MODULE__.t
  def unary(x) do
    :heap.unary(x)
  end

  @doc """
  The smallest element of the heap
  """
  @spec peak(__MODULE__.t) :: element
  def peak(x) do
    :heap.peak(x)
  end

  @doc """
  A heap whose smallest element is the minimum of the element in
  question and the smallest element of the heap in question
  """
  @spec insert(__MODULE__.t, element) :: __MODULE__.t
  def insert(x, y) do
    :heap.insert(y, x)
  end

  @doc """
  A heap alongside an element where that element would be the smallest
  if it were in the heap
  """
  @spec extract(__MODULE__.t) :: {__MODULE__.t, element}
  def extract(x) do
    :heap.extract(x)
  end

  @doc """
  A heap with the same elements as the list in question
  """
  @spec heapify(list(integer)) :: __MODULE__.t
  def heapify(x), do: heapify(x, Heap.zero())

  defp heapify([], z) do
    z
  end
  defp heapify([x|y], z) do
    heapify(y, Heap.insert(z, x))
  end

  @doc """
  A list in ascending order (w/ all the same elements as the heap)
  """
  @spec listify(__MODULE__.t) :: list(integer)
  def listify(x), do: listify(x, [])

  defp listify(x, y) do
    if Heap.zero?(x) do
      Enum.reverse(y)
    else
      {i, j} = Heap.extract(x)
      listify(i, [j|y])
    end
  end
end
