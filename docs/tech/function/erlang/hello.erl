-module(hello).
-compile([export_all]).

% Define a function to create a new process
create_process(N) ->
    spawn(fun() -> loop(N) end).

% Define a function that receives and processes messages
loop(N) when N > 0 ->
    receive
        {From, Message} ->
            io:format("Received ~p from ~p~n", [Message, From]),
            loop(N - 1)
    end;
loop(0) ->
    io:format("Process finished.~n").

% Start the main process
start() ->
    P1 = create_process(3),
    P2 = create_process(2),
    
    % Send messages to the processes
    P1 ! {self(), "Hello from P1"},
    P2 ! {self(), "Hello from P2"},
    P1 ! {self(), "How are you?"}.
