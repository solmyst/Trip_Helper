function calculateTrip() {
    const startingPoint = document.getElementById('startingPoint').value;
    const destination = document.getElementById('destination').value;
    const numberOfPeople = document.getElementById('numberOfPeople').value;

    // Use POST for the trip calculation
    fetch('http://localhost:8081/calculateTrip', {
        method: 'POST', // Change to POST
        headers: {
            'Content-Type': 'application/json' // Set content type to JSON
        },
        body: JSON.stringify({
            startingPoint: startingPoint,
            destination: destination,
            numberOfPeople: numberOfPeople
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json(); // Assume the response is JSON
    })
    .then(data => {
        console.log('Trip Data:', data);
        document.getElementById('tripCost').innerText = `Total Cost: ${data.cost}`;
        
        // Now fetch route details
        return fetch(`http://localhost:8081/route`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                startingPoint: startingPoint,
                destination: destination
            })
        });
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
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

        // Save trip details to localStorage
        localStorage.setItem("tripCost", data.cost);
        localStorage.setItem("tripDistance", data.distance);
        localStorage.setItem("tripDuration", data.duration);
        localStorage.setItem("startingPoint", startingPoint);
        localStorage.setItem("destination", destination);
        
        // Redirect to the trip cost page
        window.location.href = "index2.html"; // Change this to the actual URL of your second page
    })
    .catch(error => {
        console.error("Error:", error);
        document.getElementById('tripCost').innerText = 'Error calculating trip';
    });
}
