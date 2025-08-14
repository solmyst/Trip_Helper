package com.yourpackage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody; 
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.yourpackage.model.Trip;
import com.yourpackage.model.TripRequest;
import com.yourpackage.service.TripService;

@RestController
@RequestMapping("/api/trip") // Define a base path for your API
public class TripController {

    @Autowired
    private TripService tripService;

    // Endpoint to calculate trip cost
    @PostMapping("/calculateTrip")
    public ResponseEntity<Trip> calculateTrip(@RequestBody TripRequest tripRequest) {
        Trip trip = tripService.calculateTripCost(
            tripRequest.getStartingPoint(),
            tripRequest.getDestination(),
            tripRequest.getNumberOfPeople()
        );
        return ResponseEntity.ok(trip); // Return the calculated trip
    }

    // Endpoint to get route details
    @PostMapping("/route")
    public ResponseEntity<List<String>> getRouteDetails(@RequestBody TripRequest tripRequest) {
        List<String> routeDetails = tripService.getRouteDetails(
            tripRequest.getStartingPoint(),
            tripRequest.getDestination()
        );
        return ResponseEntity.ok(routeDetails); // Return the route details
    }

    // Endpoint to get trip information (for the second page)
    @GetMapping("/info") // Endpoint to retrieve trip info
    public ResponseEntity<TripRequest> getTripInfo(@RequestParam String startingPoint, @RequestParam String destination, @RequestParam int numberOfPeople) {
        TripRequest tripInfo = new TripRequest();
        tripInfo.setStartingPoint(startingPoint);
        tripInfo.setDestination(destination);
        tripInfo.setNumberOfPeople(numberOfPeople); // Capture number of people as well
        return ResponseEntity.ok(tripInfo); // Return the trip info for the second page
    }
}
