// src/main/java/com/yourpackage/service/TripService.java
package com.yourpackage.service;

import com.yourpackage.model.Trip;
import java.util.List;

public interface TripService {
    Trip calculateTripCost(String startingPoint, String destination, int numberOfPeople);
    List<String> getRouteDetails(String startingPoint, String destination);
}
