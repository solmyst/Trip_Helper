function calculateTrip() {
    const startingPoint = document.getElementById('startingPoint').value;
    const destination = document.getElementById('destination').value;
    const numberOfPeople = document.getElementById('numberOfPeople').value;

    // Create a JavaScript object to hold the trip details
    const tripRequest = {
        startingPoint: startingPoint,
        destination: destination,
        numberOfPeople: parseInt(numberOfPeople) // Ensure number is an integer
    };

    // Send the trip details as a JSON object in the request body
    fetch(`http://localhost:8081/api/trip/calculateTrip`, { // Ensure the correct URL
        method: 'POST',
        headers: {
            'Content-Type': 'application/json' // Specify content type
        },
        body: JSON.stringify(tripRequest) // Convert the object to a JSON string
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok: ' + response.statusText);
        }
        return response.json();
    })
    .then(data => {
        console.log('Trip Data:', data);
        document.getElementById('tripCost').innerText = `Total Cost: ${data.cost}`;
        
        // Fetch route details
        return fetch(`http://localhost:8081/api/trip/route`, { // Ensure the correct URL for route
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ startingPoint, destination }) // Send starting and destination points
        });
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok: ' + response.statusText);
        }
        return response.json();
    })
    .then(routeData => {
        const routeDetailsElement = document.getElementById('routeDetails');
        routeDetailsElement.innerHTML = ""; // Clear previous route details

        routeData.forEach(route => {
            const li = document.createElement("li");
            li.innerText = route;
            routeDetailsElement.appendChild(li);
        });
    })
    .catch(error => {
        console.error("Error:", error);
        document.getElementById('tripCost').innerText = 'Error calculating trip';
    });
    document.getElementById("tripForm").addEventListener("submit", function(event) {
        event.preventDefault(); // Prevent default form submission
    
        const startingPoint = document.getElementById("startingPoint").value;
        const destination = document.getElementById("destination").value;
        const numberOfPeople = document.querySelector('.people-selection .active').textContent;
    
        // Create a data object to send
        const tripData = {
            startingPoint: startingPoint,
            destination: destination,
            numberOfPeople: numberOfPeople
        };
    
        // Send data to the backend
        fetch("http://localhost:8080/calculateTrip", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(tripData)
        })
        .then(response => response.json())
        .then(data => {
            // Assuming data contains tripCost, tripDistance, and tripDuration
            localStorage.setItem("startingPoint", startingPoint);
            localStorage.setItem("destination", destination);
            localStorage.setItem("tripCost", data.tripCost);
            localStorage.setItem("tripDistance", data.tripDistance);
            localStorage.setItem("tripDuration", data.tripDuration);
    
            // Redirect to the second page
            window.location.href = "index2.html";
        })
        .catch(error => {
            console.error("Error:", error);
        });
    });
    
}
