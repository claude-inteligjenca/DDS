-module(fourth).

-export([inc_key/2, eval/0]).


inc_key(_Key, []) ->
    [];
% inc_key(Key, [{Head, Count} | Tail]) when Key == Head ->
%     [{Head, Count + 1} | inc_key(Key, Tail)];
inc_key(Key, [{Key, Count} | Tail]) ->
    [{Key, Count + 1} | inc_key(Key, Tail)];
inc_key(Key, [Tuple | Tail]) ->
    [Tuple | inc_key(Key, Tail)].


eval() ->
    {ok, Mod} = io:read("Module name> "),
    {ok, Fun} = io:read("Function name> "),
    % Mod:Fun(1, 20).
    {ok, Args} = io:read("Argument list> "),
    apply(Mod, Fun, Args).














