run() ->
    Pid = spawn(fun ping/0),
    Pid ! self(),
    receive
        pong -> ok
    end.
ping() ->
    receive
        From -> From ! pong     % ❶ From中包含发送方ID
    end.