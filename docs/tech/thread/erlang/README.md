# Erlang Concurrency Demo

Erlang 以**轻量级进程**实现并发，每个进程占用约300-500字节，可轻松创建数万个并发进程。

## 核心概念

| 特性 | 说明 |
|------|------|
| **spawn** | 创建新进程 |
| **消息传递** | `Pid ! Message` 发送，`receive` 接收 |
| **进程字典** | 每个进程有独立状态，无共享内存 |
| **链接/监控** | 进程故障传播机制 |

## 运行示例

```bash
./erlang
# 或
cd erlang && erl -noshell -eval "thread:start(), init:stop()." -s
```

## 示例演示

1. **Demo 1**: 10,000 进程创建 (81ms)
2. **Demo 2**: Client-Server 消息传递模式
3. **Demo 3**: 4 worker 并行 Map (100项/6ms)
4. **Demo 4**: Ping-Pong 进程交互

## 关键代码片段

### 1. 启动进程

```erlang
Pid = spawn(fun() -> do_something() end),
```

### 2. 发送/接收消息

```erlang
%% 发送消息
Pid ! {request, self(), Data},

%% 接收消息
receive
    {response, Result} -> handle(Result)
after 5000 -> timeout
end
```

### 3. 并行 Map

`thread.erl:95-107` 展示了如何用多个 worker 并行处理数据：

```erlang
parallel_map(Fun, List, NumWorkers) ->
    Chunks = chunk_list(List, ChunkSize),
    Parent = self(),
    WorkerPids = [spawn(fun() ->
        Result = [Fun(X) || X <- Chunk],
        Parent ! {worker_result, self(), Result}
    end) || Chunk <- Chunks],
    collect_results(WorkerPids, []).
```

### 4. Ping-Pong 进程交互

`thread.erl:149-162` 展示了两个进程之间的双向通信：

```erlang
ping_loop(PongPid, 0) ->
    PongPid ! finished,
    receive finished -> ok end;
ping_loop(PongPid, Count) ->
    receive
        {start, _} ->
            PongPid ! {ping, self()},
            ping_loop(PongPid, Count);
        pong ->
            PongPid ! {ping, self()},
            ping_loop(PongPid, Count - 1)
    end.
```

## 文件说明

- `thread.erl` - 主程序源码
- `thread.beam` - 编译后的字节码
- `./erlang` - 运行脚本
