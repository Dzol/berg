[![Build Status](https://travis-ci.org/Dzol/heap.svg?branch=master)](https://travis-ci.org/Dzol/heap)

# Heap

A Minimum Heap for Integers in Erlang.

## What is it?

Google _Priority Queue_ or _Pairing Heap_ or find them on Wikipedia.
You might be familiar with the heap from **Heap-Sort**, **Dijkstra's**, or **Prim's**.

## Why?

This is a good starting place to learn Erlang from but **not** about Erlang processes.
This is a pretty involved Erlang program but its domain isn't complicated.
It involves modules, procedures, lists, and tuples.
It's has OTP structure with documentation, type specifications, and a test suite.

## Documentation

Point a browser at `doc/index.hmtl`.

## Interesting Make Targets

Test with `make` and build the documentation with `make doc`.

## Exercise:

* Change the data-structure to accommodate arbitrary values.
* Change the data-structure to write a procedure called `weight/1`.
* Write procedures called `listify/1` and `listify/2` (extraction).
* Write a procedure `heapify/1` (insertion).
