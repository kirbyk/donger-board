package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"log"
	"net/http"
)

func main() {
	r := mux.NewRouter()

	r.HandleFunc("/", HomeHandler)
	r.HandleFunc("/products", ProductsHandler)
	r.HandleFunc("/products/{key}", ProductHandler)

	http.Handle("/", r)

	log.Println("the server is listening on port 7777")
	log.Fatal(http.ListenAndServe("localhost:7777", nil))
}

func HomeHandler(w http.ResponseWriter, req *http.Request) {
	log.Println("serving", req.URL)
	fmt.Fprintln(w, "Welcome to /")
}

func ProductsHandler(w http.ResponseWriter, req *http.Request) {
	log.Println("serving", req.URL)
	fmt.Fprintln(w, "Welcome to /products")
}

func ProductHandler(w http.ResponseWriter, req *http.Request) {
	log.Println("serving", req.URL)
	log.Println(req.UserAgent())

	vars := mux.Vars(req)
	name := vars["key"]

	w.WriteHeader(http.StatusOK)
	fmt.Fprintln(w, "Welcome to /products/", name)
}
