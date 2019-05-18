%% ===================================================================
%% @copyright 2016 Joseph Yiasemides
%% @author <joseph.yiasemides@erlang-solutions.com>
%% @doc A <b>Minimum</b> Heap for <b>Integers</b> in Erlang.
%% @reference Google "Priority Queue" or "Pairing Heap" or find them
%% on Wikipedia.
%% @end
%% ===================================================================

-module(heap).
-export([zero/0]).
-export([zero/1]).
-export([unary/1]).
-export([peak/1]).
-export([insert/2]).
-export([extract/1]).

%% Our heap is a structure with an integer value and a list of
%% children (heaps). The integer value of any heap is smaller than
%% those of its children.
-type heap() :: [] | {Value :: integer(), Children :: list(heap())}.


%% -------------------------------------------------------------------
%% Interface
%% -------------------------------------------------------------------

%% @doc The zero value of a heap.
-spec zero() -> Z :: heap().
zero()       -> [].

%% @doc Return a unary heap with the given value.
-spec unary(Value :: integer()) -> U :: heap().
unary(Value)                    -> {Value, []}.

%% @doc <b>Predicate</b>: is this the zero value of a heap? It'll fail
%% for something that does not have the structure of a heap. True if
%% it is a zero heap. False if the heap has cardinality greater than
%% or equal to one.
-spec zero(H :: heap())                     -> boolean().
zero([])                                    -> true;
zero({V, C}) when is_integer(V), is_list(C) -> false.

%% @doc The heap with the given integer value inserted onto the given
%% heap.
-spec insert(Value :: integer(), H :: heap()) -> I :: heap().
insert(Y, H) when is_integer(Y)               -> merge(H, unary(Y)).

%% @doc The leading value kept on this heap. Named `peak' in the sense
%% that it is the value at the <i>peak</i> of the given heap.
-spec peak(H :: heap())              -> Root :: integer().
peak({Value, C})
  when is_integer(Value), is_list(C) -> Value.

%% @doc Extract the smallest value off of the given heap.
-spec extract(H :: heap()) -> {I :: heap(), Root :: integer()}.
extract({Value, []})
  when is_integer(Value)   -> #{heap => zero(), element => Value};
extract({Value, Children})
  when is_integer(Value), is_list(Children) -> #{heap => pair(Children), element => Value}.


%% -------------------------------------------------------------------
%% Ancillary
%% -------------------------------------------------------------------

-spec pair([heap()]) -> heap().
pair([])         -> zero();
pair([H])        -> H;
pair([I,J|Rest]) -> merge(merge(I, J), pair(Rest)).

-spec merge(heap(), heap()) -> heap().
merge([], I)                -> I;
merge(H, [])                -> H;
merge(H, I)                 ->
    C = fun (X, Y) -> X - Y end,
    case C(value(H), value(I)) < 0 of
	true ->
	    heap(H, I);
	false ->
	    heap(I, H)
    end.

heap(X, Y) ->
    {value(X), [Y|children(X)]}.

value({V, _}) ->
    V.

children({_, C}) ->
    C.
