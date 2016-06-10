package main

import (
	"encoding/json"
	"net/http"

	"github.com/julienschmidt/httprouter"
	"gopkg.in/mgo.v2"
	"gopkg.in/mgo.v2/bson"
	"strconv"
)

type (
	// TrendingDongerController represents the controller for operating on the TrendingDonger resource
	TrendingDongerController struct {
		session *mgo.Session
	}
)

type Response struct {
	Status  string           `json:"status"`
	Message string           `json:"message"`
	Data    []TrendingDonger `json:"data"`
}

// NewTrendingDongerController provides a reference to a TrendingDongerController with provided mongo session
func NewTrendingDongerController(s *mgo.Session) *TrendingDongerController {
	return &TrendingDongerController{s}
}

// GetTrendingDongers retrieves an individual user resource
func (ctrl TrendingDongerController) GetTrendingDongers(w http.ResponseWriter, r *http.Request, p httprouter.Params) {
	// Stub trending dongers
	trendingDongers := []TrendingDonger{}

	// default limit of 50, otherwise use "limit" GET param
	limit, limitErr := strconv.Atoi(r.FormValue("limit"))
	if limitErr != nil {
		limit = 50
	}

	// Fetch dongers
	dbErr := ctrl.session.DB("dongerBoard").C("trending").Find(bson.M{}).Sort("-visits").Limit(limit).All(&trendingDongers)
	if dbErr != nil {
		w.WriteHeader(404)
		return
	}

	resp := Response{
		Status:  "success",
		Message: "Successfully fetched trending dongers.",
		Data:    trendingDongers,
	}

	// Marshal provided interface into JSON structure
	j, err := json.Marshal(resp)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// Write content-type, statuscode, payload
	w.Header().Set("Content-Type", "application/json; charset=utf-8")
	w.WriteHeader(200)
	w.Write(j)
}
