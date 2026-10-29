# Erlang

## Code

[Erlang-and-OTP-in-Action-Source](https://github.com/erlware/Erlang-and-OTP-in-Action-Source)

[Erlang Hello World Example](https://www.thegeekstuff.com/2010/05/erlang-hello-world-example/)

## Compile

```sh
sudo apt-get install erlang-ic
erlc helloworld.erl

$ ls
helloworld.beam  helloworld.erl

erl -noshell -s helloworld start -s init stop

###

erlc hello.erl
# hello.beam

erl>

c(hello).

hello:start().

halt().
```
