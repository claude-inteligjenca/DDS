Sequential problems to solve
Task 1: Search for the same elements (8 points)
Define the function equals/2. The function takes two lists as arguments and returns the positions of the equal elements in the lists.

equals([any()], [any()]) -> [integer()].

Test cases:

test:equals([],[]) == []
test:equals([1],[]) == []
test:equals([1,1,1],[1,2,1])  == [1,3]
test:equals([1,1,1,2,2,2,3,3,3],[1,2,1,1,2,1]) == [1,3,5]
test:equals([1,1,1,2,2,2,3,3,3],[1,2,1,1,2,1,3,3,3,3,3,3,3]) == [1,3,5,7,8,9]
test:equals([1,1,1,2,2,2,3,3,3],"abcdefg") == []
test:equals([1,1,1,2,2,2,3,3,3],[a,b,c,d]) == []
test:equals("firstlist", "secondlist") == []
test:equals(" firstlist", "secondlist") == [7,8,9,10]
Task 2: Alternating reduce (10 points)
Define the function reduce_alter/1. The function calculates a value from the elements of the list by applying addition and multiplication operations in pairs:

 1. the function starts by taking the first and second elements of the list and adding them.

2. then the function takes the previously calculated value and the third element of the list and multiplies them

3. then the function takes the result of the previous multiplication and adds the fourth element of the list to it

4. then the function takes the result of the previous step and multiplies it with the fifth element of the list

5. and so on and so on...

Example:

[212,313,414,515,616] -> ((212+313)*414+515)*616 

reduce_alter([integer()]) -> integer() | not_defined

Test cases:

test:reduce_alter([212,313,414,515,616]) == 134204840
test:reduce_alter([]) == not_defined
test:reduce_alter([212]) == 212
test:reduce_alter([1,1,1,1,1,1]) == 4
test:reduce_alter([1,2,1,2,1,2,1]) == 7
test:reduce_alter([111,222,333,444]) == 111333
test:reduce_alter([10,10,10,10,10,10,10]) == 21100
Task 3: Filtering by position (15 points) - without error handling 12 points
Define the function filter/3 that evaluates a predicate on the elements of two lists simultaneously and returns the last pairs where the predicate returned the same value for the elements (true or false). The return value is a two-element map: the key true is associated with the pairs of the elements where the predicate returned true, and the key false is associated with the pair where the predicate returned false.  If no pair is found to the key false or true, not_found should be returned as a value.

The predicate might raise a runtime error during the evaluation. In this case, that pair should be omitted from the result. The solution is accepted without error handling as well for 12 points.

Help: using a map to store the return value helps you in the implementation because the keys are unique in a map, and once you want to add a value with the same key, the old value is replaced.

filter(fun(any()) -> true | false end, [any()], [any()]) -> map()

Examples:
Pred = fun erlang:is_integer/1
List1 = [1,2]
List2 = [33,44]
Pred(1) = true, Pred(33) = true
Pred(2) = true, Pred(44) = true
Both for the first element of L1 (1) and for the first element of L2 (33) the predicate returns true. So the pair {1,33} is a possible value for the map key true: #{true => {1,33}}. But in the next step, we check the second element of the list L1 (2) and L2 (44). Both return true, so we need to record this as a value for the key true: #{true => {2,44}}. We found no pairs where both values are false, so the final result is #{false => not_found,true => {2,44}}

--------------------------------------
Pred = fun erlang:is_integer/1
List1 = [1,a]
List2 = [33,b]
Pred(1) = true, Pred(33) = true
Pred(a) = false, Pred(b) = false
Both for the first element of L1 (1) and for the first element of L2 (33) the predicate returns true. So the pair {1,33} is a possible value for the map key true: #{true => {1,33}}.  In the next step, we check the second element of the list L1 (a) and L2 (b). Both return false, so we need to record this as a value for the key false: #{false => {a,b}}. So the final value is  #{false => {a,b},true => {1,33}}

--------------------------------------
Pred = fun erlang:is_integer/1
List1 = [1,2]
List2 = [33,b]
Pred(1) = true, Pred(33) = true
Pred(a) = false, Pred(b) = false
Both for the first element of L1 (1) and for the first element of L2 (33) the predicate returns true. So the pair {1,33} is a possible value for the map key true: #{true => {1,33}}.  In the next step, we check the second element of the list L1 (2) and L2 (b). The first one returns true, and the second one returns false, so we skip these values. We found no pairs where both values are false, so the final result is #{false => not_found,true => {1,33}}

Test cases:

test:filter(fun erlang:is_integer/1, [3], [3]) == #{false => not_found,true => {3,3}}
test:filter(fun erlang:is_integer/1, [0, 1,2,3, 6], [0, 1,2,3, 5]) == #{false => not_found,true => {6,5}}
test:filter(fun erlang:is_integer/1, [0, 1,2,d, 3, 6], [0, 1,2,d, 3, 5])  == #{false => {d,d},true => {6,5}}
test:filter(fun erlang:is_integer/1, [0, 1,2,d, 3, 6, 5], [0, 1,2,d, 3, 5, d])  == #{false => {d,d},true => {6,5}}
test:filter(fun erlang:is_integer/1, [a], [a,d,f]) == #{false => {a,a},true => not_found}
test:filter(fun erlang:is_integer/1, [a,d,f,g,g], [a,d,f]) == #{false => {f,f},true => not_found}
test:filter(fun(X) -> X + 1 < 1 end, [a,d,f,g,g], [a,d,f])  == #{false => not_found,true => not_found}
test:filter(fun(X) -> X + 1 < 11 end, [1,d,f,g,g], [1,d,f]) == #{false => not_found,true => {1,1}}
test:filter(fun(X) -> X + 1 < 11 end, [1,11, d,f,g,g], [1,11,d,f]) == #{false => {11,11},true => {1,1}}
test:filter(fun(X) -> X + 1 < 11 end, [1,11, d,f,g,g], [1,11, 12, d,f])  == #{false => {11,11},true => {1,1}}
test:filter(fun(X) -> X + 1 < 11 end, [], []) == #{false => not_found,true => not_found}
test:filter(fun(X) -> X + 1 < 11 end, [], [h])  == #{false => not_found,true => not_found}
test:filter(fun(X) -> X + 1 < 11 end, [], [1]) == #{false => not_found,true => not_found}
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 

Task 1: Merging frequencies (10 points)
Define the function merge_freq/2. The function takes two lists as arguments where both lists contain frequency pairs: {Elem::term(), Freq::integer()}. The function returns the merged frequency list. If an element appears in both lists the merged frequency is the sum of the frequencies. 

 

merge_freq([{Elem::term(), Freq::integer()}], [{Elem::term(), Freq::integer()}]) -> [{Elem::term(), Freq::integer()}].

Test cases:

The order of the elements in the return value is not specified, so the return value of the function is sorted in the following tests:


lists:usort(test2:merge_freq([{a,1}], [{c,1},{a,12}])) == [{a,13},{c,1}]. 
lists:usort(test2:merge_freq([{a,1}, {c,1}, {d,1}, {b,2}], [{d,1},{c,12}])) == [{a,1},{b,2},{c,13},{d,2}]. 
lists:usort(test2:merge_freq([{a,1}, {c,1}, {d,1}, {g,2}], [{c,12},{e,2},{f,3},{w,2}])) == [{a,1},{c,13},{d,1},{e,2},{f,3},{g,2},{w,2}]. 
lists:usort(test2:merge_freq([{a,1}, {32,1}, {d,13}, {"apple",2}], [{d,1},{c,12}])) == [{32,1},{a,1},{c,12},{d,14},{"apple",2}]. 
lists:usort(test2:merge_freq([{a,1}, {32,1}, {d,13}, {"apple",2}], [])) == [{32,1},{a,1},{d,13},{"apple",2}]. 
lists:usort(test2:merge_freq([{a,1}, {"a",2}], [])) == [{a,1},{"a",2}]. 
lists:usort(test2:merge_freq([],[{a,1}, {"a",2}])) == [{a,1},{"a",2}]. 
lists:usort(test2:merge_freq([],[])) == []. 
Task 2: Sum frequencies (10 points)
Define the function sum_freq/2. The function takes a map and a list as arguments. The map contains frequencies of some Erlang terms and the list contains some Erlang terms. The function needs to calculate the sum of the frequencies of the elements listed in its list argument and returns a pair. The first element of the pair is the sum, and the second one is the map which is the original map argument extended with the Elem => not_defined association when an element from the list is not found in the map. 

sum_freq(map(), [any()]) -> {integer(), map()}

Test cases:

test2:sum_freq(#{a => 12, b => 13}, [a]) == {12,#{a => 12,b => 13}}. 
test2:sum_freq(#{a => 12, b => 13}, [b,a]) == {25,#{a => 12,b => 13}}. 
test2:sum_freq(#{a => 12, b => 13}, [b,c,a]) == {25,#{a => 12,b => 13,c => not_found}}. 
test2:sum_freq(#{a => 12, b => 13}, []) == {0,#{a => 12,b => 13}}. 
test2:sum_freq(#{}, []) == {0,#{}}. 
test2:sum_freq(#{}, [a,b]) == {0,#{a => not_found,b => not_found}}. 
test2:sum_freq(#{a => 12, b => 13, c=>13}, [b, a]) == {25,#{a => 12,b => 13,c => 13}}. 
test2:sum_freq(#{a => 12, b => 13, c=>13}, []) == {0,#{a => 12,b => 13,c => 13}}. 
test2:sum_freq(#{a => 12, b => 13, c=>13}, [b, e]) == {13,#{a => 12,b => 13,c => 13,e => not_found}}. 
Task 3:  Apply (10 points) - without error handling 8 points
Define the function apply_times/2 that takes a function F and a frequency list L as arguments. It evaluates F on the elements of a frequency list by applying the function on the element as many times as its frequency.

If the evaluation of the function F fails on the element, you have to put the atom failing_operation to the result list. 

filter(fun(any()) -> any() end, [{any(), integer()}]) -> list()

Test cases:

test2:apply_times(fun(X) -> X + 1 end, [{1, 12}, {3, 3}, {4, 12}]) == [13,6,16]. 
test2:apply_times(fun(X) -> X * 2 end, [{1, 12}, {3, 3}, {4, 12}]) == [4096,24,16384]. 
test2:apply_times(fun(X) -> X + 1 end, [{u, 12}, {3, 3}, {s, 12}]) == [failing_operation,6,failing_operation]. 
test2:apply_times(fun(X) -> X + 1 end, []) == []. 
test2:apply_times(apple, []) ==  []. 
test2:apply_times(apple,  [{1, 12}, {3, 3}, {4, 12}]) == [failing_operation,failing_operation,failing_operation]. 
 

 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Task 1: Difference of lists
Compare two lists (position-by-position), and return the differences! The result should include the elements of the first list that differ from the elements of the second. The function should check all the elements of the first list.

Function name

differences

Test cases

exam:differences("","") == [].
exam:differences("","apple") == [].
exam:differences("apple", "") == "apple".
exam:differences("apple", "apple") == [].
exam:differences("apple", "peach") == "apple".
exam:differences("apple", "apfel") == "ple".
exam:differences([1,2,3], [3,2,1]) == [1,3].

Task 2: Apply all
Define a function that takes a list of functions and a list of some elements as arguments.  The function applies each function to all the elements of the list. The order of the evaluation matters. First, the first given function should be evaluated on all the elements of the list, then the second, etc.

Function name

applyAll

Test cases

exam:applyAll([fun(A) -> A+1 end, fun(A) -> A*2 end], [1,2,3,4]) == [2,3,4,5,2,4,6,8].
exam:applyAll([fun(A) -> A+2 end], []) == [].
exam:applyAll([], [apple, pear]) == [].
exam:applyAll([fun erlang:is_list/1], [apple, pear]) == [false,false].
exam:applyAll([fun erlang:is_list/1], [apple, pear, []]) == [false,false,true].

Task 3: Positions
Define a function that returns the positions of a given element in a list! The indexing starts with `1`.

Function name

getPositions

Test cases

exam:getPositions($e, "apple") == [5].
exam:getPositions($p, "apple") == [2,3].
exam:getPositions(1, []) == [].
exam:getPositions(1, [1,3,2,1,2,34,21,1,1,4]) == [1,4,8,9].

Task 4: Riffle shuffle
Define the riffle shuffle algorithm on lists! The function takes a list as an argument, it splits the list into two "equal" parts (if the number of elements is odd, then the first part should be shorter), then merges the two sublists into a new list alternately (one from the first, one from the second repeatedly).

Example:

   [1,2,3,4,5]

  [1,2] [3,4,5]

   [1,3,2,4,5]

Function name

riffleShuffle

Test cases

exam:riffleShuffle([]) == [].
exam:riffleShuffle([1]) == [1].
exam:riffleShuffle([1,2]) == [1,2].
exam:riffleShuffle([1,2,3]) == [1,2,3].
exam:riffleShuffle([1,2,3,4]) == [1,3,2,4].
exam:riffleShuffle([1,2,3,4,5]) == [1,3,2,4,5].
exam:riffleShuffle([1,2,3,4,5,6]) == [1,4,2,5,3,6].
exam:riffleShuffle([1,2,3,4,5,6,7]) == [1,4,2,5,3,6,7].
exam:riffleShuffle([1,4,2,5,3,6,7]) == [1,5,4,3,2,6,7].

Task 5: Error handling
Modify the definition of the applyAll/2  function to handle the runtime errors occurring during the evaluations of the function arguments on the elements. Put the atom bad_fun_argument into the returning list when a runtime error occurs.

 

Test cases

exam:applyAll([fun(A) -> A+2 end], [1,apple]) == [3,bad_fun_argument].
exam:applyAll([fun erlang:atom_to_list/1, fun(A) -> A*2 end], [1,apple,3, '12']) ==[bad_fun_argument, "apple", bad_fun_argument, "12", 2,  bad_fun_argument, 6, bad_fun_argument].
exam:applyAll([fun(A) -> A+1 end, fun(A) -> A*2 end], [1,2,3,4]) == [2,3,4,5,2,4,6,8].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Task 1: Repeat an operation while a certain condition holds (10 point)
Define the higher-order function repeat_while/3. The function iteratively applies an operation on a value while a given condition holds for the value.

The function takes three arguments:

1. The first argument is a predicate (a function with arity 1), that returns either true or false.

2. The second argument is a function with only one argument. This function is repeatable/iterable, that is the domain and the range/codomain are of the same type.

3. The value that has to be iteratively transformed with the given function to fulfil the given condition.

The function returns a list of values, that involves the values of previous computations.

repeat_while(fun((any()) -> boolean()), fun(any()) -> any()), anzy) -> any())

Test cases:

test:repeat_while(fun(E) -> E > 10 end, fun(E) -> E - 1 end, 20) == [20,19,18,17,16,15,14,13,12,11]

test:repeat_while(fun(E) -> E > 65 end, fun(E) -> E - 1 end, 66) == "B"

test:repeat_while(fun(E) -> E > 65 end, fun(E) -> E - 1 end, 65) == []

test:repeat_while(fun(E) -> E > 600 end, fun(E) -> E - 1 end, 10) == []

Task 2: Repeated elements at least *n* times (10 points)
Define the function elems_repeated_at_least_ntimes/2. The function returns the elements of the given list that are repeated at least N times in the list. The resulted list should contain only unique elements.

The arguments of the function are:

1. a number that is the threshold value for the minimum of repetition,

2. a list that has to be processed.

elems_repeated_at_least_ntimes(integer(), [any()]) -> [any()]

Test cases:

**Note:** It is not mandatory to return values in a sorted order!

test:elems_repeated_at_least_ntimes(0, [1,4,3]) == [1,3,4]

test:elems_repeated_at_least_ntimes(-3, [1,4,3]) == [1,3,4]

test:elems_repeated_at_least_ntimes(2, [1,4,3]) == []

test:elems_repeated_at_least_ntimes(2, [1,4,1,3]) == [1]

test:elems_repeated_at_least_ntimes(2, [2,1,4,1,3,2]) == [1,2]

test:elems_repeated_at_least_ntimes(2, [2,1,4,1,3,2,2]) == [1,2]

test:elems_repeated_at_least_ntimes(2, "Mississippi") == "ips"

test:elems_repeated_at_least_ntimes(4, "Mississippi") == "is"

Task 3: Evaluate Polynomial (10 points)
Define the function eval_polynomial/2 that evaluates a polynomial given by its coefficients at a given point.

The arguments of the functions are:

1. a list of coefficients,

2. a given point (numeric value).

For example, the list [3,4,5,6,0,1] of coefficients stands for the polynomial 3*x^5 + 4*x^4  + 5*x^3 + 6*x^2 + 0*x^1 + 1*x^0. The former polynomial evaluated in point 3 gives the value 1243.0.

eval_polynomial([number()], number()) -> number()

Test cases:

test:eval_polynomial([3,4,5,6,0,1], 1) == 19.0

test:eval_polynomial([3,4,5,6,0,1], 3) == 1243.0

test:eval_polynomial([32,4,5,1,0], 1) == 42.0

test:eval_polynomial([32,4,5,1,0], 0) == 0.0

test:eval_polynomial([], 3) == 0

 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 

XOR encryption

Your task is to implement the XOR encryption: https://en.wikipedia.org/wiki/XOR_cipher 
To help you we have created a detailed algorithm to implement. Please follow the instructions step by step. During the evaluation, we will evaluate each function separately. In total, you can get 22 (+4 optional) points.

The algorithm has two arguments: a text to encode (Text) and a key (Key). The main steps of the algorithms:
 1. Create the bitstring representation of the Text.
 2. Repeat the key to reach the same length as Text.
 3. Create the bitstring representation of the repeated Key. 
 4. Apply the XOR operation on the resulted bit sequences.


In the implementation, you have to use a list representation for bitstrings. Thus the character $o, which is represented by its ASCII code 111, is represented by [0,1,1,0,1,1,1,1].

An example for the binary representation:

%%% FROM WIKIPEDIA (https://en.wikipedia.org/wiki/Binary_number)
In the binary system, each digit represents an increasing power of 2, with the rightmost digit representing 20, the next representing 21, then 22, and so on. The equivalent decimal representation of a binary number is sum of the powers of 2 which each digit represents. For example, the binary number 100101 is converted to decimal form as follows:
1001012 = [ ( 1 ) × 25 ] + [ ( 0 ) × 24 ] + [ ( 0 ) × 23 ] + [ ( 1 ) × 22 ] + [ ( 0 ) × 21 ] + [ ( 1 ) × 20 ]
1001012 = [ 1 × 32 ] + [ 0 × 16 ] + [ 0 × 8 ] + [ 1 × 4 ] + [ 0 × 2 ] + [ 1 × 1 ]
1001012 = 3710
%%%
In our representation the 100101 number is represented in a reversed order in the list: [1,0,1,0,0,1]. So the smallest exponent (2^0) is the first element of the list, and so on... 


We will use the following types:
 bitString() = list(0|1)
 char() = number()
 string() = list(char())

In your solutions, you have to use all of the following language elements: list comprehension, higher-order function application, fun expression, primitive recursive function, tail-recursive function.

Functions to implement:

1. Convert a decimal number to a bitstring (2 points): toBitrString(A::number()) -> Res::bitString()

The function converts a decimal number to a binary number. The binary number has to be represented by a list of zeros and ones. 
Examples:
  toBitString(0)         = []
  toBitString(2)         = [0,1]
  toBitString(10)       = [0,1,0,1] 
  toBitString(12321) = [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1]

2. Converting a character to a bitstring (2 points): charToBitString(A::char())->Res::bitString()

The function converts a character to a binary number. Characters are represented as a list with 8 elements, thus when the character code can be represented with a shorter list, then you have to tag the list with zeros from the right.

 charToBitString($a) = [1, 0, 0, 0, 0, 1, 1, 0]
 charToBitString($H) = [0, 0, 0, 1, 0, 0, 1, 0]


3. Converting a bitstring to a character (2 points): bitStringToChar(A::bitString())->Res::char()

The function calculates the number represented by the bitstring.

Examples:
 bitStringToChar([1,0,0,0,1,0,1]) = 81 ($Q)
 bitStringToChar([1,0,0,0,1,1])    = 49 ($1).

4. xOr operation on bitsrtings (2 points): xOr(A::bitString(), B::bitString()) -> Res::bitString()

Define the xOr function that calculates the xor operation step by step on the elements of the bitstrings. Please note, that the lengths of bitstrings are not necessarily the same.

Examples:
 xOr([], [1,1,0,1,0,1])          = [1, 1, 0, 1, 0, 1]
 xOr([1,1,0,1,0,1], [1,0,1])  = [0, 1, 1, 1, 0, 1]

5. Encryption (3 points). encrypt(Text::string(), Key::string()) -> Chioer::string()

Using the previously defined functions implement the xor encryption.

 1. Repeat the Key until the length of the sequence is at least the length of the Text (RepKey).
 2. Apply the xor operation on the bitstring representation of Text and RepKey (BitResult).
 3. Create the text representation of the bitstring.

Example:
 encrypt("Save Our Souls!", "SOS") =  [0,46,37,54,111,28,38,61,115,0,32,38,63,60,114]  ("^@.%6o^\&=s^@ &?<r")

6. Decryption (1 point): decrypt(Cipher::string(), Key::string()) -> Text::string()

The encryption is symmetric, so you can easily define the decryption using encryption.

Example:
 decrypt( encrypt("Save Our Souls!", "SOS") , "SOS") = "Save Our Souls!"

7. Repeated text (2 points): isCycledIn(A::string(), B::string()) -> true|false

Check whether string B can be constructed as a repetition of string A.

Examples:
 isCycledIn("ab", "")           = false
 isCycledIn("ab", "cdddd") = false
 isCycledIn("ab", "abb")     = false
 isCycledIn("ab", "abab")   = true
 isCycledIn("ab", "ababa") = true

8. Determining the Key (4 points): getKey(Text::string(), Cipher::string()) -> Key::string()

Determine the Key of the encryption based on the original (Text) and the encrypted text (Cipher).

The encryption is symmetric therefore we can easily determine the repeated key sequence using the decrypt function (RepKey). Then the only task is to find the shortest text that is repeated in RepKey.

Example:
 getKey("Save Our Souls!", encrypt("Save Our Souls!", "SOS")) = "SOS"

9. Decoding messages (4 points): decodeMessage(Cipher::string(), PartOfText::string()) -> Text::string()

We have the encoded text (Cipher) and we know a part of the original message (PartOfText). Your task is to implement a function that decodes the whole message. We assume that the text is encoded with a short key and the length of the known text is at least the length of the key!

decodeMessage(encrypt("Save Our Souls!", "SOS"), "Save") = "Save Our Souls!"

You may define two versions of this function. The base version supposes that the known part of the text is at the beginning of the original text. 

Then for (4 more) extra points, you can solve this problem without this assumption, so subtext can be located anywhere in the original text.
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 

The link of the [documentation.](http://erlang.org/doc/man/)
--------------------------------------------------------

Task no. 0:
===========

Copy the following declaration form to your Erlang file and fill in the required data:

~~~~
%% <Name>
%% <Neptun ID>
%% <DDS, TEST1>
%% <22.03.2018.>
%% This solution was submitted and prepared by <Name, Neptun ID> for the DDS Retake Test Sequential.
%% I declare that this solution is my own work.
%% I have not copied or used third party solutions.
%% I have not passed my solution to my classmates, neither  made it public.
%% Students’ regulation of Eötvös Loránd University (ELTE Regulations Vol. II. 74/C. § ) states that as long as a student presents another student’s work - or at least the significant part of it - as his/her own performance, it will count as a disciplinary fault. The most serious consequence of a disciplinary fault can be dismissal of the student from the University.
~~~~



Task no. 1: 
=================================

Ethiopian multiplication is a method of multiplying integers using only addition, doubling, and halving.

Define three functions: 
	one to halve an integer,
	one to double an integer, and
	one to state if an integer is even.

Use them to create multiplier(L,R), that takes the two numbers (Left and Rigth) and compute their product in the following way:

	Half the Left number until you get to 1, at the same time Double the Rigth number for the same amount of times. 
	Discard any value from Rigth where the corresponding value in Left is even.
	Sum all number left in right to produce the result of L*R.

 Ex.   17    34            discard 68,136 and 272
        8    68 			34 + 544 == 17*34
        4   136 
        2   272 
        1   544
		


%%%%%%%%%%%%#1  
~~~
multiplier(integer(),integer()) -> integer()
~~~

Test cases:
-----------

**Do not forget to change the name of the module!**

~~~
test:multiplier(12,3)==(12*3).
test:multiplier(0,0)== forbidden.
test:multiplier(7,0)== forbidden.
~~~

Task no. 2: is_numeric/1
==========================

Create the function is_numeric(S), that check if a given string is composed only by numbers (Integer and Float is good), return true if the argument passed is either an integer or a float.
**IMPORTANT:** you need to reimplement the function, do not use the built-in function is_number/1. 


~~~
is_numeric(S:list()) -> boolean()
~~~

Test cases:
-----------

**Do not forget to change the name of the module!**

~~~
test:is_numeric("123") ==true.
test:is_numeric("12.3")==true.
test:is_numeric(".12.3")==false.
test:is_numeric(".12.3.")==false.
test:is_numeric("123.")==false.
test:is_numeric("")==false.

~~~

Task no. 3: replace/3
==============================

Define the replace/3 function that takes three strings as arguments and
replaces every other occurrence of the substring Old with New in Str.
~~~
replace(Str::list(), Old::list(), New::list())-> list()
~~~

Test cases:
-----------

**Do not forget to change the name of the module!**

~~~
test:replace("AppleAppleApple", "Apple", "Pear")=="PearApplePear"
test:replace("AppleAppleApple", "Apple", "")=="Apple"
test:replace("AppleAppleApple", "App", "Pear")=="PearleApplePearle"

~~~

Task no. 4: partition/2
=================

Define the higher-order function partition/2, which will take a list and a boolean Predicate P and return two Lists: the first one that has the terms which satisfy P, and the second one a list for the others terms.
**IMPORTANT:** Use recursion, you are not allowed to use the built in function lists:partition/2.

~~~
partition(Predicate::fun(any() -> boolean()), List(E))->Result::list(E)
~~~
test:partition(fun(X)-> X>10 end ,[7,10,8,155,133] )==[[155,133],[7,10,8]]
test:partition(fun(X)-> X rem 2==0  end ,[7,8,2222,223] )==[[8,2222],[7,223]]
test:partition(fun(X)-> is_atom(X)  end ,[[1,2],[alma],hello] )==[[hello],[[1,2],[alma]]]

~~~
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 

Task no. 4: until
=================

Define the higher-order function `until/3`. The function iteratively applies an operation on a value until a given condition holds for the computed value.

The function takes three arguments:

 1. The first argument is a predicate (a function with arity 1), that returns either true or false.
 
 2. The second argument is a function with only one argument. This function is repeatable/iterable, that is the domain and the range/codomain are of the same type.

 3. The value that has to be iteratively transformed with the given function to fulfill the given condition.

~~~
until(Predicate::fun(any() -> boolean()), Operation::(any() -> any()) -> Result::any())
----------------------------------------------------
twice/2
a function that takes a value and a functun and applies it twice to the value

flip/1
Define a function flip/1 that takes a binary function as argument, and applies its arguments in reverse order.

For example:

1> F = function:flip(fun (X,Y) -> X div Y end).
#Fun<function.0.67435388>
2> F(10,20).
-----------------------------------------------------------
while(F,C,P)    
For example:
while(fun(X)-> X+1 end,fun(X)-> X<10 end,0).
----------------------------------------------------------
Write the function days/0 in module 'year' that returns the list of every {month,day} pair of a 365-day calendar. Define the function with a list comprehension.

Hint: use the lists:member/2 function to verify its good.

-----------------------------------------------------------

Task no. 2: bin_to_decimal
==========================

Define the function named `bin_to_decimal/1` that converts a binary to the corresponding decimal number.
The input of the function is a list of bits (list of values `0` and `1`) and the output is a decimal number.

For example, for the list `[1,0,1,0,1,0]` the output is the value `42`.

The list `[1,0,1,0,1,0]` stands for $101010_2$, that is interpreted as $1*2^5 + 0*2^4  + 1*2^3 + 0*2^2 + 1*2^1 + 0*2^0 == 42$

**IMPORTANT:** The usage of function `list_to_integer/2` is forbidden in the implementation!

-----------------------------------------------------------
Define a function guess:game/1 that takes an integer greater than one as argument. The function generates a random integer not greater than the argument. It returns an anonymous function, which also takes an integer as argument, and returns congratulations whenever the argument equals to the random integer, try_again otherwise.

Use random:uniform/1 to generate a random number.

For instance:

1> F = guess:game(3).
#Fun<game.2.130281041>
2> F(1).
try_again
2> F(2).
congratulations
3> F(3).
try_again

--------------------------------------------------------

Task no. 1: first_n_abundant_nums
=================================

Define the function `first_n_abundant_nums/1` that returns the first `N` abundant numbers in increasing order, where `N` is the argument of the function.

Description from the Wikipedia: *"In number theory, an abundant number or excessive number is a number for which the sum of its proper divisors is greater than the number itself. The integer `12` is the first abundant number. Its proper divisors are `1`, `2`, `3`, `4` and `6` for a total of `16`. The amount by which the sum exceeds the number is the abundance. The number `12` has an abundance of `4`, for example."*

~~~
first_n_abundant_nums(integer()) -> list(integer())
~~~