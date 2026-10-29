erlc helloworld.erl
erl -noshell -s helloworld start -s init stop

cc = erlc
erl = erl
ext = erl
out = beam
src = hello
fun = start

all: src run clean
src: $(src).$(ext)
	$(cc) $^
run:
	$(erl) -noshell -s $(src) $(fun) -s init stop
clean:
	rm $(src).$(out)