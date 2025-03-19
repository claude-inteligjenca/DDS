-module(shapes).

-export([area/1]).


area({circle, R}) ->
    R * R * math:pi();

area({square, N}) ->
    N*N;

area({rectangle, H, W}) ->
    H*W.
