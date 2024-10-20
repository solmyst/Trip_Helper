import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/trip")
public class TripController {

    @PostMapping("/calculate")
    public TripResponse calculateTrip(@RequestBody TripRequest request) {
        double distance = request.getDistance();
        double fuelEfficiency = request.getCar().getFuelEfficiency(); // in km/l
        double fuelPrice = 100.0; // example fuel price per liter

        // Calculate total fuel needed
        double totalFuel = distance / fuelEfficiency;
        // Calculate total cost
        double totalCost = totalFuel * fuelPrice;

        // Add a per-person cost calculation
        int numOfPeople = request.getNumberOfPeople();
        double costPerPerson = totalCost / numOfPeople;

        // Create response
        TripResponse response = new TripResponse();
        response.setTotalCost(totalCost);
        response.setCostPerPerson(costPerPerson);

        return response;
    }
}
