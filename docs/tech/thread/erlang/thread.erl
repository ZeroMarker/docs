-module(thread).
-export([start/0, demo_spawn/0, demo_message_passing/0, demo_parallel_map/0, demo_ping_pong/0]).

%% ============================================================================
%% Erlang Concurrency Demo
%% ============================================================================
%% This module demonstrates Erlang's lightweight process concurrency:
%% - Spawning thousands of concurrent processes
%% - Message passing between processes
%% - Parallel computation with map-reduce pattern
%% - Ping-pong between processes
%% ============================================================================

%% ----------------------------------------------------------------------------
%% Entry point
%% ----------------------------------------------------------------------------
start() ->
    io:format("=== Erlang Concurrency Demo ===~n"),
    demo_spawn(),
    demo_message_passing(),
    demo_parallel_map(),
    demo_ping_pong(),
    io:format("=== All demos completed ===~n").

%% ----------------------------------------------------------------------------
%% Demo 1: Spawn many lightweight processes
%% Erlang can easily spawn tens of thousands of concurrent processes
%% ----------------------------------------------------------------------------
demo_spawn() ->
    io:format("~n--- Demo: Spawning 10,000 processes ---~n"),
    Start = erlang:monotonic_time(millisecond),
    
    %% Spawn 10,000 processes that each send a message back
    Parent = self(),
    Pids = [spawn(fun() -> Parent ! {done, self()} end) || _ <- lists:seq(1, 10000)],
    
    %% Wait for all responses
    [receive {done, Pid} -> ok end || Pid <- Pids],
    
    End = erlang:monotonic_time(millisecond),
    io:format("Spawned and synchronized 10,000 processes in ~p ms~n", [End - Start]).

%% ----------------------------------------------------------------------------
%% Demo 2: Message passing between processes
%% Demonstrates the actor model with request-response pattern
%% ----------------------------------------------------------------------------
demo_message_passing() ->
    io:format("~n--- Demo: Message Passing ---~n"),
    
    %% Create a simple server process
    Server = spawn(fun() -> server_loop(0) end),
    
    %% Send messages from multiple client processes
    Parent = self(),
    Clients = [spawn(fun() ->
        Server ! {request, self(), ClientId},
        receive {response, Msg} -> Parent ! {client_done, ClientId, Msg} end
    end) || ClientId <- lists:seq(1, 5)],
    
    %% Collect responses
    [receive {client_done, Id, Msg} -> 
        io:format("Client ~p received: ~p~n", [Id, Msg])
    end || _ <- Clients],
    
    Server ! stop.

server_loop(State) ->
    receive
        {request, From, ClientId} ->
            Response = io_lib:format("Hello from client ~p, server state: ~p", [ClientId, State]),
            From ! {response, Response},
            server_loop(State + 1);
        stop ->
            ok
    end.

%% ----------------------------------------------------------------------------
%% Demo 3: Parallel map using Erlang processes
%% Distributes work across multiple worker processes
%% ----------------------------------------------------------------------------
demo_parallel_map() ->
    io:format("~n--- Demo: Parallel Map ---~n"),
    
    Data = lists:seq(1, 100),
    NumWorkers = 4,
    
    Start = erlang:monotonic_time(millisecond),
    Result = parallel_map(fun compute_heavy/1, Data, NumWorkers),
    End = erlang:monotonic_time(millisecond),
    
    io:format("Parallel map of 100 items with ~p workers: ~p ms~n", [NumWorkers, End - Start]),
    io:format("First 5 results: ~p~n", [lists:sublist(Result, 5)]).

%% Parallel map implementation
parallel_map(Fun, List, NumWorkers) ->
    ChunkSize = (length(List) + NumWorkers - 1) div NumWorkers,
    Chunks = chunk_list(List, ChunkSize),
    Parent = self(),
    
    %% Spawn workers
    WorkerPids = [spawn(fun() ->
        Result = [Fun(X) || X <- Chunk],
        Parent ! {worker_result, self(), Result}
    end) || Chunk <- Chunks],
    
    %% Collect results in order
    collect_results(WorkerPids, []).

chunk_list(List, Size) ->
    chunk_list(List, Size, []).

chunk_list([], _, Acc) ->
    lists:reverse(Acc);
chunk_list(List, Size, Acc) ->
    {Chunk, Rest} = lists:split(min(Size, length(List)), List),
    chunk_list(Rest, Size, [Chunk | Acc]).

collect_results([], Acc) ->
    lists:flatten(lists:reverse(Acc));
collect_results(Pids, Acc) ->
    receive
        {worker_result, Pid, Result} ->
            collect_results(lists:delete(Pid, Pids), [Result | Acc])
    end.

%% Simulate heavy computation
compute_heavy(X) ->
    %% Simulate some CPU work
    _ = lists:foldl(fun(N, Acc) -> Acc + N * N end, 0, lists:seq(1, 1000)),
    X * X.

%% ----------------------------------------------------------------------------
%% Demo 4: Ping-Pong between processes
%% Classic concurrency demonstration
%% ----------------------------------------------------------------------------
demo_ping_pong() ->
    io:format("~n--- Demo: Ping Pong ---~n"),
    
    Pong = spawn(fun() -> pong_loop() end),
    Ping = spawn(fun() -> ping_loop(Pong, 5) end),
    
    Ping ! {start, Pong},
    
    receive
        game_over ->
            io:format("Ping-pong game completed~n")
    end.

ping_loop(PongPid, 0) ->
    PongPid ! finished,
    receive finished -> ok end;
ping_loop(PongPid, Count) ->
    receive
        {start, _} ->
            io:format("Ping ~p~n", [Count]),
            PongPid ! {ping, self()},
            ping_loop(PongPid, Count);
        pong ->
            io:format("Ping received pong (~p remaining)~n", [Count - 1]),
            PongPid ! {ping, self()},
            ping_loop(PongPid, Count - 1)
    end.

pong_loop() ->
    receive
        {ping, From} ->
            io:format("Pong received ping~n"),
            From ! pong,
            pong_loop();
        finished ->
            self() ! game_over,
            ok;
        game_over ->
            exit(normal)
    end.
