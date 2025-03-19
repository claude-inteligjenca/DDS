Notes:
This is a closed-book exam. You are not allowed to use any kind of help, just the Erlang documentation: https://www.erlang.org/doc/man_index.html
Local documentation can be found in "C:\Program Files\ErlangOTP\doc" or download the attached zip: otp_doc_html_26.2.5.4.zip
VSCode extension: erlang-ls.erlang-ls-0.0.46.vsix
In the implementation, you can use library functions and list comprehensions, but at least one working recursive definition is needed.
Windows users:
Start Erlang ("C:\Program Files\ErlangOTP\bin\erl.exe")
Change the working directory in the Erlang shell: cd("C:/Path/To/Your/Module”).
Linux users:
From the folder containing your Erlang module, please type erl.
Task 0:
Fill and copy the following declaration form to your Erlang file and fill in the required data:

%% <Name>
%% <Neptun ID>
%% <DDS, Sequential test>
%% <05.11.2024>
%% This solution was submitted and prepared by <Name, Neptun ID> for the DDS Sequential Test.
%% I declare that this solution is my work.
%% I have not copied or used third-party solutions.
%% I have not passed my solution to my classmates nor made it public.
%% Students’ regulation of Eötvös Loránd University (ELTE Regulations Vol. II. 74/C. § ) states that as long as a student presents another student’s work - or at least a significant part of it - as his/her performance, it will count as a disciplinary fault. The most serious consequence of a disciplinary fault can be the student's dismissal from the University.
Task 1:
Calculate the sum of the prefixes of a list. For example, in the case of the input list [A,B,C], the result should contain [A, A+B, A+B+C ].

Our function sums/1 takes a list of values as an input and returns the sum of the prefixes.

Error handling: When the list contains an element where the + operation is not applicable (a runtime error occurs), please ignore the value from the output. If you implement a recursive incremental summarisation, you must stop the computation: [1,2,a,b]  returns [1, 1+2], because 1+2+a and 1+2+a+b would return a runtime error.

Test function:

test_sums() ->
    {test:sums([]) == [],
     test:sums([2]) == [2],
     test:sums([2,3]) == [2,5],
     test:sums([2,3,8]) == [2,5,13],
     test:sums([2,3,8,42]) == [2,5,13,55],
     test:sums([2,3,8,42,a]) == [2,5,13,55],
     test:sums([2,3,8,42,a,b]) == [2,5,13,55],
     test:sums([2,3,8,42,a,b,1]) == [2,5,13,55],
     test:sums([2,3,8,42,a,b,1,2]) == [2,5,13,55],
     test:sums([2, a]) == [2],
     test:sums([a]) == [],
     lists:sum(test:sums(lists:seq(1,100))) == 171700
    }.
Task 2:
We have a warehouse represented with a map. For example, #{apple=>12, pear=>2} means we have 12 apples and 2 pears in our shop. We have a list of items as an input: [apple, dress, headset]. We would like to know what kinds of items are not available in the warehouse and summarise the amount of the available items.

So, our count_items/2 function takes two arguments: the map of the warehouse and a list of items. Iterate through the list, count the items found in the warehouse, and collect the ones that are not available.

Test function:

test_count_items() ->
    {test:count_items(#{apple=>12}, [apple]) == {12,[]},
     test:count_items(#{apple=>12}, [apple, pear]) == {12,[pear]},
     test:count_items(#{}, [orange]) == {0,[orange]},
     test:count_items(#{apple=>12, pera=>2}, [apple, pear]) == {12,[pear]},
     test:count_items(#{apple=>12, pera=>2}, [apple, pear]) == {12,[pear]},
     test:count_items(#{apple=>12, pear=>2}, [apple, pear]) == {14,[]},
     test:count_items(#{}, [apple, pear]) == {0,[apple,pear]},
     test:count_items(#{apple=>12, pear=>2, banana=>100}, [apple, pear, plum, orange, banana]) == {114,[plum,orange]},
     test:count_items(#{}, []) == {0,[]}
    }.
Task 3:
Implement the generate_greetings/2 function that takes two lists as arguments. The first contains some greeting text, and the second one contains names. Concatenate the element of the lists to get all possible greetings. For example, if we have ["Hi"] and ["Melinda"] as input, we will return ["Hi Melinda"].

When some non-string input occurs, ignore it: ["Hi", 12] and ["Melinda"] should return ["Hi Melinda"].

Note: You can use ++ for concatenating strings, but do not forget that it may result in an improper list:  "Hi" ++ 12 == [72,105|12]. We do not need these in the output.

Test function:

test_generate_greetings() ->
    {test:generate_greetings(["Hi"], ["Melinda"]) == ["Hi Melinda"],
     lists:sort(test:generate_greetings(["Hi", "Szia"], ["Melinda"])) == lists:sort(["Hi Melinda", "Szia Melinda"]),
     lists:sort(test:generate_greetings(["Hi", "Szia"], ["Melinda", "Youssef"])) == lists:sort(["Hi Melinda","Hi Youssef","Szia Melinda","Szia Youssef"]),
     lists:sort(test:generate_greetings(["Hi"], ["Melinda", "Youssef"])) == lists:sort(["Hi Melinda","Hi Youssef"]),
     lists:sort(test:generate_greetings(["Hi", "Hello", "Szia", "Ciao"], ["Melinda", "Youssef", "Lola", "Elisabeth", "David"])) == 
        lists:sort(["Hi Melinda","Hi Youssef","Hi Lola","Hi Elisabeth", "Hi David","Hello Melinda","Hello Youssef","Hello Lola", 
            "Hello Elisabeth","Hello David","Szia Melinda", "Szia Youssef","Szia Lola","Szia Elisabeth","Szia David",
            "Ciao Melinda","Ciao Youssef","Ciao Lola","Ciao Elisabeth", "Ciao David"]),
     test:generate_greetings([], ["Lola", "Lala"]) == [],
     test:generate_greetings(["Hi"], []) == [],
     test:generate_greetings(["Hi"], [12]) == [],
     test:generate_greetings(["Hi"], [12, "Melinda"]) == ["Hi Melinda"],
     test:generate_greetings(["Hi", 12], [12]) == [],
     test:generate_greetings(["Hi", 12], ["12"]) == ["Hi 12"],
     lists:sort(test:generate_greetings(["Hi", 12], ["12", "Melinda"])) == lists:sort(["Hi 12","Hi Melinda"])
    }.