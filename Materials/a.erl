-module(a).
-export([foo/0]).

foo() -> 1.

% ...~ % erl
% Erlang/OTP 27 [erts-15.2.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Eshell V15.2.1 (press Ctrl+G to abort, type help(). for help)
% 1> 1+2.
% 3
% 2> 1
%    +3
%    .
% 4
% 3> lists:nth(3, [a,b,c,d]).
% c
% 4> code:get_path().
% ...
% 5> ls( "/opt/homebrew/Cellar/erlang/27.2.1/lib/erlang/lib/stdlib-6.2/ebin").
% ...
% 6> 
%    pwd().
% /Users/melindatoth
% ok
% 7> q().
% ok
% 8> %                                                                            melindatoth@Mac ~ % cd Desktop 
% melindatoth@Mac Desktop % erl
% Erlang/OTP 27 [erts-15.2.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Eshell V15.2.1 (press Ctrl+G to abort, type help(). for help)
% 1> pwd().
% /Users/melindatoth/Desktop
% ok
% 2> code:get_path().
% ...
% 3> code:add_patha("/Users/melindatoth").
% true
% 4> code:get_path().
% ...
% 5> cd("/Users/melindatoth").
% /Users/melindatoth
% ok
% 6> c(a).
% {error,non_existing}
% 7> pwd().
% /Users/melindatoth
% ok
% 8> code:get_path().
% ...
% 9> cd("/Users/melindatoth/Desktop").
% /Users/melindatoth/Desktop
% ok
% 10> c(a).
% {ok,a}
% 11> beam_disasm:file("a.beam").
% {beam_file,a,
%            [{module_info,0,2},{module_info,1,4}],
%            [{vsn,[38082781571302591617761973045730973994]}],
%            [{version,"8.5.4"},
%             {options,[]},
%             {source,"/Users/melindatoth/Desktop/a.erl"}],
%            [{function,module_info,0,2,
%                       [{label,1},
%                        {line,0},
%                        {func_info,{atom,a},{atom,module_info},0},
%                        {label,2},
%                        {move,{atom,a},{x,0}},
%                        {call_ext_only,1,{extfunc,erlang,get_module_info,1}}]},
%             {function,module_info,1,4,
%                       [{line,0},
%                        {label,3},
%                        {func_info,{atom,a},{atom,module_info},1},
%                        {label,4},
%                        {move,{x,0},{x,1}},
%                        {move,{atom,a},{x,0}},
%                        {call_ext_only,2,
%                                       {extfunc,erlang,get_module_info,2}}]}]}
% 12> c(a).
% a.erl:3:1: Warning: function foo/0 is unused
% %    3| foo() -> 1.
% %     | ^

% {ok,a}
% 13> a:foo().
% ** exception error: undefined function a:foo/0
% 14> c(a).
% {ok,a}
% 15> a:foo().
% 1
% 16> beam_disasm:file("a.beam").
% {beam_file,a,
%            [{foo,0,2},{module_info,0,4},{module_info,1,6}],
%            [{vsn,[71795369517400311907241228987997300060]}],
%            [{version,"8.5.4"},
%             {options,[]},
%             {source,"/Users/melindatoth/Desktop/a.erl"}],
%            [{function,foo,0,2,
%                       [{label,1},
%                        {line,1},
%                        {func_info,{atom,a},{atom,foo},0},
%                        {label,2},
%                        {move,{integer,1},{x,0}},
%                        return]},
%             {function,module_info,0,4,
%                       [{line,0},
%                        {label,3},
%                        {func_info,{atom,a},{atom,module_info},0},
%                        {label,4},
%                        {move,{atom,a},{x,0}},
%                        {call_ext_only,1,{extfunc,erlang,get_module_info,1}}]},
%             {function,module_info,1,6,
%                       [{line,0},
%                        {label,5},
%                        {func_info,{atom,a},{atom,module_info},1},
%                        {label,6},
%                        {move,{x,0},{x,1}},
%                        {move,{atom,a},{x,0}},
%                        {call_ext_only,2,
%                                       {extfunc,erlang,get_module_info,2}}]}]}
% 17> a:module_info().
% [{module,a},
%  {exports,[{foo,0},{module_info,0},{module_info,1}]},
%  {attributes,[{vsn,[71795369517400311907241228987997300060]}]},
%  {compile,[{version,"8.5.4"},
%            {options,[]},
%            {source,"/Users/melindatoth/Desktop/a.erl"}]},
%  {md5,<<54,3,73,3,2,194,41,50,66,175,96,208,102,199,37,92>>}]
% 18> 1+2.
% 3
% 19> a:foo().
% 1
% 20> 45 + a:foo().
% 46
% 21> 45 + a:foo() * a:foo().
% 46
% 22> 1.
% 1
% 23> 34.
% 34
% 24> 34.2.
% 34.2
% 25> 2.
% 2
% 26> 2#11.
% 3
% 27> 10#11.
% 11
% 28> 8#11.
% 9
% 29> $a.
% 97
% 30> <<1,2,3>>.
% <<1,2,3>>
% 31> <<1:4,2:4,3:4>>.
% <<18,3:4>>
% 32> <<1:4,2:4,3:4, 5:4>>.
% <<18,53>>
% 33> atom.
% atom
% 34> true.
% true
% 35> false.
% false
% 36> 1 == 2.
% false