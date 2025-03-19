-module(second).
-export([foo/0, foo/1, foo/2]).
% -compile([export_all]).
% -import(first,[foo/0]).
% -author("Youssef").

% -type(bit() :: 0|1).
% -spec(foo(bit(), integer())-> list()| integer()).

foo()->    ok.

foo(A)->   A+1.

foo(ok, _) -> ok;
foo([],[1|_])-> one;
foo(A, A) -> A + A;
foo(Aqwdd, Qwerwe) -> Aqwdd - Qwerwe.