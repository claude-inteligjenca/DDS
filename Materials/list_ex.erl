-module(list_ex).

-export([inc/1, inc_list/1, sum_list/1, inc_list_natural/1, inc_list_n/2]).
-export([inc_gen/1, inc_list_n_natural/2]).

inc(X) -> X + 1.

inc_gen(X) -> fun(I) -> X + I end.

inc_list([H|T]) ->
    [inc(H) | inc_list(T)];
inc_list([]) ->
    [].

sum_list([H|T]) ->
    H + sum_list(T);
sum_list([]) ->
    0.

inc_list_natural(L) ->
    inc_list_natural(L, []).
inc_list_natural([H|T], Acc) ->
    inc_list_natural(T, [inc(H)|Acc]);
inc_list_natural([], Acc) ->
    lists:reverse(Acc).

inc_list_n([H|T], N) ->
    Incrementer = inc_gen(N),
    [Incrementer(H) | inc_list_n(T, N)];
inc_list_n([], _) ->
    [].

inc_list_n_natural(L, N) ->
    Incrementer = inc_gen(N),
    inc_list_n_natural(L, [], Incrementer).

inc_list_n_natural([H|T], Acc, Incrementer) ->
    inc_list_n_natural(T, [Incrementer(H) | Acc], Incrementer);
inc_list_n_natural([], Acc, _) ->
    lists:reverse(Acc).
