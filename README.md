![The Tatra Range](./tatra.jpg)

[![Build Status](https://travis-ci.org/Dzol/berg.svg?branch=master)](https://travis-ci.org/Dzol/berg)

# Berg

[Berg](http://dzol.github.io/berg) is a Minimum [Heap](https://en.wikipedia.org/wiki/Heap_(data_structure)) for Integers in Elixir.
The underlying library is a Two Pass [Pairing Heap](https://en.wikipedia.org/wiki/Pairing_heap) in Erlang.

## What is it?

The interface is akind to a [Priority Queue](https://en.wikipedia.org/wiki/Priority_queue).
You might be familiar with the heap from algorithms such as **Heap-Sort**, **Dijkstra's**, or **Prim's**.

## Rationale

This is a program w/ which to learn sequential Erlang + how to build an Elixir library around it.
It is an involved Erlang program (involving modules, functions, lists, and tuples) but its domain isn't complicated.
The project has OTP Application structure, documentation, dialyzer declarations, and a test suite (`mix test`).

A **property** suite is written in Elixir (`mix property`).
