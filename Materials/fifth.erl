-module(fifth).
-export([apply_twice/2, freq_map/1, suml/1, count_del/2, eval/3]).

freq_map(L) ->
    freq_map(L, #{}).

freq_map([H|T], Map) ->
    case Map of
        % pattern match on key presence
        #{H:=C} -> freq_map(T, Map#{H=>C+1});
        _ -> freq_map(T, Map#{H=>1})
    end;
freq_map([], Map) ->
    Map.

apply_twice(F, Arg) ->
    X = F(Arg),
    F(X).

suml(L) ->
    lists:foldl(fun(E, S) -> E + S end, 0, L).

count_del(E, L) ->
% Can't use because of shadowing: observe compilation errors
    % lists:foldl(fun(E, {Count, Rem}) -> {Count+1, Rem};
    lists:foldl(fun(H, {Count, Rem}) when H == E -> {Count+1, Rem};
                   (H, {Count, Rem}) -> {Count, [H|Rem]}
                end, {0, []}, L).

eval(M, F, Arg) ->
    %M:F(Arg).
    try
        %M:F(Arg)
       X = M:F(Arg),
       X * 2
    of
        Value -> {return_value, Value}
    catch
        error:function_clause -> "No matching definition";
        _:undef -> "The function is not defined";
        _:badarith:_ -> "The return value is not a number";
        _:_:Stack -> {"The stactrace of anything else", Stack}
    end.
