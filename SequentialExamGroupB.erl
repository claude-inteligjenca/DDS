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
%% <DDS, Sequential retake>
%% <12.11.2024>
%% This solution was submitted and prepared by <Name, Neptun ID> for the DDS Sequential Retake.
%% I declare that this solution is my work.
%% I have not copied or used third-party solutions.
%% I have not passed my solution to my classmates nor made it public.
%% Students’ regulation of Eötvös Loránd University (ELTE Regulations Vol. II. 74/C. § ) states that as long as a student presents another student’s work - or at least a significant part of it - as his/her performance, it will count as a disciplinary fault. The most serious consequence of a disciplinary fault can be the student's dismissal from the University.
Task 1:
Calculate the product of the prefixes of a list. For example, in the case of the input list [A,B,C], the result should contain [A, A*B, A*B*C ].

Our function mutex/1 takes a list of values as an input and returns the product of the prefixes.

Error handling: When the list contains an element where the * operation is not applicable (a runtime error occurs), please ignore the value from the output. If you implement a recursive incremental summarisation, you must stop the computation: [1,2,a,b]  returns [1, 1*2], because 1*2*a and 1*2*a*b would return a runtime error.

Test function:

test_mutex() ->
    {test:mutex([]) == [],
     test:mutex([2]) == [2],
     test:mutex([2,3]) == [2,6],
     test:mutex([2,3,8]) == [2,6,48],
     test:mutex([2,3,8,42]) == [2,6,48,2016],
     test:mutex([2,3,8,42,a]) == [2,6,48,2016],
     test:mutex([2,3,8,42,a,b]) == [2,6,48,2016],
     test:mutex([2,3,8,42,a,b,1]) == [2,6,48,2016],
     test:mutex([2,3,8,42,a,b,1,2]) == [2,6,48,2016],
     test:mutex([2, a]) == [2],
     test:mutex([a]) == [],
     lists:sum(test:mutex(lists:seq(1,10))) == 4037913
    }.
Task 2:
We have a garden represented with a map. For example, #{tomato => 12, carrot => 5} means we have 12 tomatoes and 5 carrots in our garden. We have a list of vegetables as an input: [tomato, lettuce, cucumber]. We would like to know which vegetables are not available in the garden and count the ones that exist but have quantities greater than the given threshold.

So, our count_vegetables/3 function takes three arguments: the map of the garden, a list of vegetables, and a threshold. Iterate through the list, count the vegetables found in the garden whose quantities are greater than the threshold, and collect the ones that are not available.

Return two pieces of information:

The total count of vegetables in the garden that have quantities greater than the threshold.
The list of missing vegetables that are not found in the garden or the amount is under the threshold.
Test function:

test_count_vegetables() ->
    {test:count_vegetables(#{tomato => 12}, [tomato], 5) == {12, []},
        test:count_vegetables(#{tomato => 12}, [tomato, lettuce], 5) == {12, [lettuce]},
        test:count_vegetables(#{}, [carrot], 5) == {0, [carrot]},
        test:count_vegetables(#{tomato => 12, carrot => 2}, [tomato, carrot], 5) == {12, [carrot]},
        test:count_vegetables(#{tomato => 12, carrot => 2}, [tomato, carrot], 10) == {12, [carrot]},
        test:count_vegetables(#{tomato => 12, carrot => 2}, [tomato, carrot], 2) == {12, [carrot]},
        test:count_vegetables(#{tomato => 12, carrot => 3}, [tomato, carrot], 2) == {15,[]},
        test:count_vegetables(#{}, [tomato, carrot], 3) == {0,[carrot,tomato]},
        test:count_vegetables(#{tomato => 12, carrot => 2, cucumber => 100}, [tomato, carrot, lettuce, cucumber], 10) == {112,[lettuce,carrot]},
        test:count_vegetables(#{}, [], 5) == {0, []}
    }.
Task 3:
Implement the generate_unique_greetings/2 function that takes two lists as arguments. The first contains some greeting text, and the second one contains names. Concatenate the element of the lists to get all possible greetings. For example, if we have ["Hi"] and ["Melinda"] as input, we will return ["Hi Melinda"].

Do not allow repeated names, ["Hi", "Hi", "Hi"], ["Melinda", "John", "Melinda"]) => ["Hi Melinda", "Hi John"].

When some non-string input occurs, ignore it: ["Hi", 12] and ["Melinda"] should return ["Hi Melinda"].

Note: You can use ++ for concatenating strings, but do not forget that it may result in an improper list:  "Hi" ++ 12 == [72,105|12]. We do not need these in the output.

Test function:

test_generate_unique_greetings() ->
    {   test:generate_unique_greetings(["Hi"], ["Melinda"]) == ["Hi Melinda"],
        test:generate_unique_greetings(["Hi", "Hi", "Hi"], ["Melinda", "Melinda", "Melinda"]) == ["Hi Melinda"],
        lists:sort(test:generate_unique_greetings(["Hi", "Szia"], ["Melinda"])) == lists:sort(["Hi Melinda", "Szia Melinda"]),
        lists:sort(test:generate_unique_greetings(["Hi", "Szia"], ["Melinda", "Youssef"])) == lists:sort(["Hi Melinda","Hi Youssef","Szia Melinda","Szia Youssef"]),
        lists:sort(test:generate_unique_greetings(["Hi"], ["Melinda", "Youssef"])) == lists:sort(["Hi Melinda","Hi Youssef"]),
        lists:sort(test:generate_unique_greetings(["Hi", "Hello", "Szia", "Ciao"], ["Melinda", "Youssef", "Lola", "Elisabeth", "David"])) == 
        lists:sort(["Hi Melinda","Hi Youssef","Hi Lola","Hi Elisabeth", "Hi David","Hello Melinda","Hello Youssef","Hello Lola", 
            "Hello Elisabeth","Hello David","Szia Melinda", "Szia Youssef","Szia Lola","Szia Elisabeth","Szia David",
            "Ciao Melinda","Ciao Youssef","Ciao Lola","Ciao Elisabeth", "Ciao David"]),
        test:generate_unique_greetings([], ["Lola", "Lala"]) == [],
        test:generate_unique_greetings(["Hi"], []) == [],
        test:generate_unique_greetings(["Hi"], [12]) == [],
        test:generate_unique_greetings(["Hi"], [12, "Melinda"]) == ["Hi Melinda"],
        test:generate_unique_greetings(["Hi", 12], [12]) == [],
        test:generate_unique_greetings(["Hi", 12], ["12"]) == ["Hi 12"],
        lists:sort(test:generate_unique_greetings(["Hi", 12], ["12", "Melinda"])) == lists:sort(["Hi 12","Hi Melinda"])
    }.