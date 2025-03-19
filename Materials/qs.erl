-module(qs).
-export([quicksort/1]).

quicksort([]) -> [];
quicksort([H |T]) ->
    quicksort([X || X <- T, X =< H]) ++ 
              [H] ++
              quicksort([X || X <- T, H < X]).
