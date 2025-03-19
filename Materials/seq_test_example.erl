-module(seq_test_example).
-export([filter/3, equals/2]).


filter(Pred, X, Y) ->
    filter(Pred, X, Y, #{false => not_found, true => not_found}).

filter(Pred, [X|Xs], [Y|Ys], Map) ->
    case {catch Pred(X), catch Pred(Y)} of
        {true, true} -> filter(Pred, Xs, Ys, Map#{ true := {X, Y}});
        {false, false} -> filter(Pred, Xs, Ys, Map#{false := {X, Y}});
        _ -> filter(Pred, Xs, Ys, Map)
    end;
filter(_, _, _, Map) ->
    Map.

% Erlang/OTP 27 [erts-15.0] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit:ns]

% Eshell V15.0 (press Ctrl+G to abort, type help(). for help)
% 1> c(seq_test_example).
% {ok,seq_test_example}
% 2> seq_test_example:filter(fun(X) -> X > 0 end, [3,4], [-1, 3]).
% #{false => not_found,true => {4,3}}
% 3> seq_test_example:filter(fun(X) -> 1/X > 0 end, [-3,4], [-1, 0]).
% #{false => {-3,-1},true => not_found}
% 4> 
    

% Task 1 (from the sample test: https://canvas.elte.hu/courses/48969/pages/sequential-problems-to-solve?module_item_id=728644) 
equals(A, B)->
    equals(A, B, 1).
equals([X|Xs], [X|Ys], Index)->
    [Index | equals(Xs, Ys, Index + 1)];
equals([_|Xs], [_|Ys], Index) ->
    equals(Xs, Ys, Index + 1);
equals(_, _, _)->
    [].

% 71> sixth:equals([1,1,1,2,2,2,3,3,3],[1,2,1,1,2,1]) == [1,3,5].
% true
% 72> sixth:equals([1,1,1,2,2,2,3,3,3],[1,2,1,1,2,1]) == [1,5].
% false