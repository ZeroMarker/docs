-module(two_sum).
-compile([export_all]).

two_sum(Target, Numbers) ->
    lists:flatten([[{X, Y} || X <- Numbers, Y <- Numbers, X + Y == Target], []]).

main() ->
    Target = 9,
    Numbers = [2, 7, 11, 15],
    Result = two_sum(Target, Numbers),
    io:format("Result: ~p~n", [Result]).


