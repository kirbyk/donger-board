package main

import (
	"github.com/julienschmidt/httprouter"
	"gopkg.in/mgo.v2"
	"log"
	"net/http"
)

// TODO: Add this as middleware
// log.Println("serving", req.URL)
// log.Println(req.UserAgent())

func main() {
	router := httprouter.New()

	trendingDongerCtrl := NewTrendingDongerController(getSession())

	router.Handle("GET", "/trending", trendingDongerCtrl.GetTrendingDongers)
	// router.Handle("POST", "/trending/poll", TrendingPollHandler)

	log.Println("the server is listening on port 7777")
	log.Fatal(http.ListenAndServe(":7777", router))
}

// getSession creates a new mongo session and panics if connection error occurs
func getSession() *mgo.Session {
	// Connect to our local mongo
	s, err := mgo.Dial("mongodb://localhost")

	// Check if connection error, is mongo running?
	if err != nil {
		panic(err)
	}

	// Deliver session
	return s
}
