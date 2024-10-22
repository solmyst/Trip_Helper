package com.yourpackage.model;

public class Trip {
    private String startingPoint;
    private String destination;
    private int distance;       // in kilometers
    private int estimatedTime;  // in minutes
    private int totalCost;      // in currency units

    // Constructor
    public Trip(String startingPoint, String destination, int distance, int estimatedTime, int totalCost) {
        this.startingPoint = startingPoint;
        this.destination = destination;
        this.distance = distance;
        this.estimatedTime = estimatedTime;
        this.totalCost = totalCost;
    }

    // Getter and Setter for startingPoint
    public String getStartingPoint() {
        return startingPoint;
    }

    public void setStartingPoint(String startingPoint) {
        this.startingPoint = startingPoint;
    }

    // Getter and Setter for destination
    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    // Getter and Setter for distance
    public int getDistance() {
        return distance;
    }

    public void setDistance(int distance) {
        if (distance < 0) {
            throw new IllegalArgumentException("Distance cannot be negative");
        }
        this.distance = distance;
    }

    // Getter and Setter for estimatedTime
    public int getEstimatedTime() {
        return estimatedTime;
    }

    public void setEstimatedTime(int estimatedTime) {
        if (estimatedTime < 0) {
            throw new IllegalArgumentException("Estimated time cannot be negative");
        }
        this.estimatedTime = estimatedTime;
    }

    // Getter and Setter for totalCost
    public int getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(int totalCost) {
        if (totalCost < 0) {
            throw new IllegalArgumentException("Total cost cannot be negative");
        }
        this.totalCost = totalCost;
    }

    // toString method for easy debugging
    @Override
    public String toString() {
        return "Trip{" +
                "startingPoint='" + startingPoint + '\'' +
                ", destination='" + destination + '\'' +
                ", distance=" + distance +
                ", estimatedTime=" + estimatedTime +
                ", totalCost=" + totalCost +
                '}';
    }
}
