%% ===================================================================
%% @copyright 2016 Joseph Yiasemides
%% @author <joseph.yiasemides@erlang-solutions.com>
%% @doc Test Suite: a <b>Minimum</b> Heap for <b>Integers</b> in
%% Erlang.
%% @reference Google "Priority Queue" or "Pairing Heap" or find them
%% on Wikipedia.
%% @end
%% ===================================================================

-module(heap_SUITE).
-compile([export_all]).

-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").


%% -------------------------------------------------------------------
%% Suite description
%% -------------------------------------------------------------------

all() ->

    [ {group, positive}
    ].

groups() ->

    [ {positive, [shuffle], success()}
    ].

success() ->

    [ main
    , interleave
    ].


%% -------------------------------------------------------------------
%% Tests
%% -------------------------------------------------------------------

main(_) ->

    %% Draw values uniformly at random. Keep a hold of these in a
    %% list. Insert these into a heap. Sort the list. Extract values
    %% from the heap into a list. The two lists are the same.

    ct:comment("Extracting from the heap gives elements in sorted order."),

    H = heap:zero(),
    R = draw(100, 256),
    I = lists:foldl(fun heap:insert/2, H, R),
    O = listify(I),
    O = lists:sort(R). %% `listify/1' does indeed perform a sort.

interleave(_) ->

    %% Follows similar intuition to the above. Testing correctness
    %% when `insert' and `extract' are interleaved. This is at the
    %% heart of the pairing heap's good amortized perfomance.

    ct:comment("Interleaving insertion and extraction gives elements in sorted order."),

    H0 = heap:zero(),

    R0 = draw(20, 256),
    H1 = lists:foldl(fun heap:insert/2, H0, R0),

    R1 = draw(20, 256),
    H2 = lists:foldl(fun heap:insert/2, H1, R1),

    {H3, O0} = listify(H2, 20),
    {O0, O1} = lists:split(20, lists:sort(R0 ++ R1)),

    R2 = draw(20, 256),
    H4 = lists:foldl(fun heap:insert/2, H3, R2),

    {H5, O2} = listify(H4, 20),
    {O2, O3} = lists:split(20, lists:sort(O1 ++ R2)),

    O3 = listify(H5).


%% -------------------------------------------------------------------
%% Ancillary
%% -------------------------------------------------------------------

listify(H) ->
    lists:reverse(listify_(H, [])).

listify_(H, L) ->
    case heap:zero(H) of
        false ->
            {I, Value} =  heap:extract(H),
            listify_(I, [Value|L]);
        true ->
            L
    end.

listify(H, N) ->
    {I, L} = listify_(H, [], N),
    {I, lists:reverse(L)}.

listify_(H, L, 0) ->
    {H, L};
listify_(H, L, N) ->
    case heap:zero(H) of
        false ->
            {I, Value} =  heap:extract(H),
            listify_(I, [Value|L], N - 1);
        true ->
            {H, L}
    end.

draw(Length, Bound) ->
    [ crypto:rand_uniform(0, Bound) || _ <- lists:seq(1, Length) ].
