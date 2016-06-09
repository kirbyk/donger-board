package main

import "gopkg.in/mgo.v2/bson"

type (
	// TrendingDonger represents the structure of our resource
	TrendingDonger struct {
		Id    bson.ObjectId `json:"id" bson:"_id"`
		Index int32         `json:"index"`
	}
)
