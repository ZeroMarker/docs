cc = ghc
src = hello
ext = hs

all: src run clean
src:
	$(cc) $(src).$(ext)
run:
	./$(src)
clean:
	rm ./$(src)
justrun:
	runghc $(src).$(ext)
