-module(four).
-export([f4/1, fif/1, freq_best/1]).

f4(L) ->
    freq_4(L, []).
freq_4([], Result) ->
    Result;
freq_4([H|T], Result) ->
    case lists:keyfind(H, 2, Result) of
        false ->A= freq_4(T, [{1 + search:count(H, T), H} | Result]);
        _ ->A= freq_4(T, Result)
    end,
    A.

fif(L) ->
    f_if(L, []).
f_if([], Result) ->
    Result;
f_if([H|T], Result) ->
    Cond = lists:keyfind(H, 2, Result),
    if Cond == false -> f_if(T, [{1 + search:count(H, T), H} | Result]);
       true -> f_if(T, Result)
    end.

freq_best([H|T] = L) ->
    {Count, Rem} = count_del(H, L), 
    [{Count, H} | freq_best(Rem) ];
freq_best([]) ->
    [].

count_del(E, [E| T]) ->
    {Count, Rem} = count_del(E, T),
    {Count + 1, Rem};
count_del(E, [ H | T]) ->
    {Count, Rem} = count_del(E, T),
    {Count, [H | Rem]};
count_del(_E, []) ->
    {0, []}.


%freq_4([H|T], Result) when not lists:keyfind(H, 2, Result) ->
%    freq_4(T, [{1 + search:count(H, T), H} | Result]);
%freq_4([_|T], Result) ->
%    freq_4(T, Result).
