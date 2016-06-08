all: clean build run

install:
	go get "github.com/gorilla/mux"

build:
	go install main.go

run:
	./bin/main

clean:
	rm -f bin/main
