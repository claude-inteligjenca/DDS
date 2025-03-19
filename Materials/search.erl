-module(search).

-export([search/2, search_prim/2]).
-export([count/2, count_prim/2]).
-export([freq/1, freq_better/1]).
-export([filter_even/2]).
search(E, [E|_T]) ->
    true;
search(E, [_|T])  ->
    search(E, T);
search(_, []) ->
    false.

% primitive recursion
search_prim(E, [H|T]) ->
    io:format("iteration~n"),
    % andalso
    (E == H) orelse search_prim(E, T);
search_prim(_, []) ->
    false.

count(E, L)->
    count(E, L, 0).
count(E, [E|T], Acc) ->
    count(E, T, Acc+1);
count(E, [_|T], Acc) ->
    count(E, T, Acc);
count(_E, [], Acc) ->
    Acc.

count_prim(E, [E|T]) ->
    1 + count(E, T);
count_prim(E, [_H|T]) ->
    0 + count(E, T);
count_prim(_, []) ->
    0.

freq(L) ->
    F = freq(L, L),
    lists:usort(F).
freq([H|T], OriginalList) ->
    [{H, count(H, OriginalList)} | freq(T, OriginalList)];
freq([], _) ->
    [].

freq_better(L) ->
    S = lists:usort(L),
    [{E, count(E, L)} || E <- S].


filter_even(From, To) ->
    [ X || X <- lists:seq(From, To), X rem 2 == 0].
