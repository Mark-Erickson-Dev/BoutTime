//
//  EventSet.swift
//  BoutTime
//
//  Created by Mark Erickson on 8/12/16.
//  Copyright © 2016 Mark Erickson. All rights reserved.
//

import Foundation

struct EventSet {
    
    var allEvents: [Event] = [
        Event(description: "Star Wars was released in theaters", date:"1977-05-25", url: "https://en.wikipedia.org/wiki/Star_Wars"),
        Event(description: "Japanese bombed Pearl Harbor", date:"1941-12-07", url: "https://en.wikipedia.org/wiki/Pearl_Harbor"),
        Event(description: "Neil Armstrong walks on the moon", date:"1969-07-20", url: "https://en.wikipedia.org/wiki/Moon_landing"),
        Event(description: "US Declaration of Independence", date:"1776-07-04", url: "https://en.wikipedia.org/wiki/United_States_Declaration_of_Independence"),
        Event(description: "Premiere of Michael Jackson's Thriller video", date:"1983-11-14", url: "https://en.wikipedia.org/wiki/Thriller_(song)"),
        Event(description: "Apple Inc. was founded", date:"1976-04-01", url: "https://en.wikipedia.org/wiki/Apple_Inc."),
        Event(description: "The first iPhone is announced by Steve Jobs", date:"2007-01-09", url: "https://en.wikipedia.org/wiki/History_of_iPhone"),
        Event(description: "JFK was assassinated", date:"1963-11-22", url: "https://en.wikipedia.org/wiki/John_F._Kennedy"),
        Event(description: "RAAF captures flying saucer in Roswell", date:"1947-07-08", url: "https://en.wikipedia.org/wiki/Roswell_UFO_incident"),
        Event(description: "Doc Brown gets the idea for the flux capacitor", date:"1955-11-05", url: "https://en.wikipedia.org/wiki/Back_to_the_Future")
    ]
    
}