-module(sixth).
-export([eval/0, equals/2, run_tests/0]).




eval() ->
    try
        % throw(apple),
        {ok, Mod} = io:read("Module name> "),
        {ok, Fun} = io:read("Function name> "),
        % Mod:Fun(1, 20).
        {ok, Args} = io:read("Argument list> "),
        Value = apply(Mod, Fun, Args),
        #{value => Value, func => {Mod, Fun, Args}}
    % of 
    %     Value -> #{value => Value, func => {Mod, Fun, Args}}
    catch
        % apple -> ok;
        % error:badarg:_Stacktrace ->
        error:badarg -> "The type of the given input is not correct";
        _:undef -> "The function does not exist";
        
        _:_:_ -> "error"
    end.
    %   _Class:_ExceptionPattern:_Stacktrace -> "Error"
%     after
%         io:format("Try's after")
%    end,
%    io:format("After").



eval2() ->
catch
    begin
        {ok, Mod} = io:read("Module name> "),
        {ok, Fun} = io:read("Function name> "),
        {ok, Args} = io:read("Argument list> "),
        apply(Mod, Fun, Args)
    end.    


% Task 1 (from the sample test: https://canvas.elte.hu/courses/48969/pages/sequential-problems-to-solve?module_item_id=728644) 
equals(A, B)->
    equals(A, B, 1).
equals([X|Xs], [X|Ys], Index)->
    [Index | equals(Xs, Ys, Index + 1)];
equals([_|Xs], [_|Ys], Index) ->
    equals(Xs, Ys, Index + 1);
equals(_, _, _)->
    [].


% This is one way that can be used to check for the test cases 
% (Checking in the terminal by copy-paste the test cases is faster, since you
% won't have time to write testing code for each function)

% to test this code:  compile then run the 'run_test()'
% if you get true then all test cases are correct else you get false if any case fails
run_tests() ->
    TestCases = [
        sixth:equals([], []) == [],
        sixth:equals([1], []) == [],
        sixth:equals([1, 1, 1], [1, 2, 1]) == [1, 3],
        sixth:equals([1, 1, 1, 2, 2, 2, 3, 3, 3], [1, 2, 1, 1, 2, 1]) == [1, 5],
        sixth:equals([1, 1, 1, 2, 2, 2, 3, 3, 3], [1, 2, 1, 1, 2, 1, 3, 3, 3, 3, 3, 3, 3]) == [1, 3, 5, 7, 8, 9],
        sixth:equals([1, 1, 1, 2, 2, 2, 3, 3, 3], "abcdefg") == [],
        sixth:equals([1, 1, 1, 2, 2, 2, 3, 3, 3], [a, b, c, d]) == [],
        sixth:equals("firstlist", "secondlist") == [],
        sixth:equals(" firstlist", "secondlist") == [7, 8, 9, 10]
    ],
    check_tests(TestCases).

check_tests(TestCases) ->
    lists:all(fun(X) -> X end, TestCases).