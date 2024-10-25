package com.yourpackage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.yourpackage.model.Trip;
import com.yourpackage.model.TripRequest; // Ensure you create this class
import com.yourpackage.service.TripService;

@RestController
public class TripController {

    @Autowired
    private TripService tripService;

    @PostMapping("/calculateTrip") // Changed to POST
    public ResponseEntity<Trip> calculateTrip(@RequestBody TripRequest tripRequest) {
        Trip trip = tripService.calculateTripCost(
            tripRequest.getStartingPoint(),
            tripRequest.getDestination(),
            tripRequest.getNumberOfPeople()
        );
        return ResponseEntity.ok(trip); // Return the calculated trip
    }

    @PostMapping("/route") // Changed to POST
    public ResponseEntity<List<String>> getRouteDetails(@RequestBody TripRequest tripRequest) {
        List<String> routeDetails = tripService.getRouteDetails(
            tripRequest.getStartingPoint(),
            tripRequest.getDestination()
        );
        return ResponseEntity.ok(routeDetails); // Return the route details
    }
}
