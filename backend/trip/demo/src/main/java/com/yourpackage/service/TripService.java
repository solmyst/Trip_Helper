package com.yourpackage.service;

import java.util.List;

import com.yourpackage.model.Trip;

public interface TripService {
    Trip calculateTripCost(String startingPoint, String destination, int numberOfPeople);
    List<String> getRouteDetails(String startingPoint, String destination);
}
