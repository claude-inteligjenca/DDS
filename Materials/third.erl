-module(third).
-export([zero/1, inc/1, 'inc atom'/1, inc_first/1, inc_tuple/1, inc_proplist/1,  inc_first2/1, inc_list/1, count/1, length/1]).
-compile({no_auto_import,[length/1]}).


zero(A) when is_atom(A) ->not_zero;
zero(0)->0.


% inc(A) when A=:= 0 -> zero;
inc(A) when A== 0 -> zero;
inc(A) -> A+1.


'inc atom' (zero) -> one;
'inc atom' (Zero) when is_atom(Zero) -> type_atom.


inc_first({0, _B} = Tuple) ->
    Tuple; % {0, _B};
inc_first({A, B}) ->
    {A+1, B}.

inc_tuple({A, B})->
    {A+1, B+1};
inc_tuple({A, B, C}) ->
    {A+1, B+1, C+1}.


% inc_first2({0, _B}) ->
%     {0, _B}.
inc_first2(T) when is_tuple(T), size(T) == 2, element(1, T) == 0 ->
    T.


inc_list([])->
    [];
inc_list([Head|Tail]) ->
    [Head+1 | inc_list(Tail)].


count([_E| Rest]) ->
    1+ count(Rest);
count(_) ->
    0.

length([_E |Rest]) ->
    1 + length(Rest);
length([])->
    0.


inc_proplist([]) ->
    [];
inc_proplist([{Head, Count} | Tail]) ->
    [{Head, Count +1} | inc_proplist (Tail)].



















