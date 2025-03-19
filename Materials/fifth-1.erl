-module(fifth).

-export([freq0/1, freq00/1, freq1/1, freq2/1, freq3/1, freq4/1]).


%L=[1,2,1,2,3]
count(E, [E| Tail])->
    1 + count(E, Tail);
count(E, [_| Tail]) ->
    count(E, Tail);
count(_, []) ->
    0.

count_tail(E, L)->
    count_tail(E, L, 0).
count_tail(E, [E| Tail], Acc)->
    count_tail(E, Tail, Acc +1);
count_tail(E, [_| Tail], Acc) ->
    count_tail(E, Tail, Acc);
count_tail(_, [], Acc) ->
    Acc.


freq0 (L) ->
    lists:uniq([ {E, count(E, L)}  ||  E <- L ]). %% usort

freq00(L)->
    freq00(L,L).
freq00([H|T], L )->
    [ {H, count(H, L)}  | freq00( T , L)  ];
freq00([], _) ->
    [].


freq1(L)->
    freq1(L, []).

freq1([H|T], Visited) ->  
    case lists:member(H,Visited) of
      true -> freq1(T, Visited);
      _ -> [{H, count(H, T) + 1} | freq1(T, [H|Visited])]
    end;

freq1([], _) ->
    [].


freq2(L)->
    freq2(L, []).

freq2([H|T], Result) ->
    case lists:keymember(H, 1, Result) of
        true -> freq2(T, Result);
        _ -> freq2(T, [{H, count(H, T) + 1}|Result])
      end;
freq2([], Result) ->
      Result.


freq3(L)->
    freq3(L, []).

freq3([H|T], Result) ->
    case lists:keyfind(H, 1, Result) of
        false -> freq3(T,[ {H, 1} | Result]);
        {H, Count} -> freq3(T, lists:keyreplace(H, 1, Result, {H, Count + 1}))
        end;
freq3([], Result) ->
        Result.


freq4(L)->
    freq4(L, #{}).

freq4([H|T], Map) ->
    case Map of
        #{H := Count} -> freq4(T, Map#{ H := Count + 1});
        _ -> freq4(T, Map#{H => 1})
        end;
freq4([], Map) ->
        Map.