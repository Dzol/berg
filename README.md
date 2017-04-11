![The Tatra Range](./tatra.jpg)

[![Build Status](https://travis-ci.org/Dzol/berg.svg?branch=master)](https://travis-ci.org/Dzol/berg)

# Berg

[Berg](http://dzol.github.io/berg) is a Minimum Heap for Integers in Elixir.
The underlying library is a Two Pass Pairing Heap in Erlang.

## What is it?

Google _Priority Queue_ or _Pairing Heap_ or find them on Wikipedia.
You might be familiar with the heap from **Heap-Sort**, **Dijkstra's**, or **Prim's**.

## Rationale

This is a program w/ which to learn Erlang (but nothing about processes) + how to build an Elixir library around it.
Though its an involved Erlang program its domain isn't complicated.
It involves modules, functions, lists, and tuples.
The project has OTP Application structure, documentation, type specifications, and a test suite (`mix test`).
A **property** suite is written in Elixir (`mix property`).
