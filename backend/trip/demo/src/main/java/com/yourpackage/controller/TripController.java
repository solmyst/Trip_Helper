// src/main/java/com/yourpackage/controller/TripController.java
package com.yourpackage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.yourpackage.model.Trip;
import com.yourpackage.service.TripService;

@RestController
public class TripController {

    @Autowired
    private TripService tripService;

    @GetMapping("/calculateTrip")
    public Trip calculateTrip(
            @RequestParam String startingPoint,
            @RequestParam String destination,
            @RequestParam int numberOfPeople) {
        return tripService.calculateTripCost(startingPoint, destination, numberOfPeople);
    }
    @GetMapping("/route")
    public List<String> getRouteDetails(
            @RequestParam String startingPoint, 
            @RequestParam String destination) {
        return tripService.getRouteDetails(startingPoint, destination);
    }
}


