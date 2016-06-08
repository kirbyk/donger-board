package main

import (
	"encoding/json"
	"fmt"
	"github.com/gorilla/mux"
	"log"
	"net/http"
)

type Book struct {
	Title  string `json:"title"`
	Author string `json:"author"`
}

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

	// vars := mux.Vars(req)
	// name := vars["key"]

	// w.WriteHeader(http.StatusOK)
	// fmt.Fprintln(w, "Welcome to /products/", name)

	book := Book{"Building Web Apps with Go", "Jeremy Saenz"}

	js, err := json.Marshal(book)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(js)
}
