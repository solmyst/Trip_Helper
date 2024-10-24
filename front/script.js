// script.js
document.querySelectorAll('.scroll-container').forEach(container => {
    const scrollLeftButton = container.querySelector('.scroll-left');
    const scrollRightButton = container.querySelector('.scroll-right');
    const suggestions = container.querySelector('.suggestions');

    scrollLeftButton.addEventListener('click', () => {
        suggestions.scrollBy({ left: -100, behavior: 'smooth' });
    });

    scrollRightButton.addEventListener('click', () => {
        suggestions.scrollBy({ left: 100, behavior: 'smooth' });
    });
});
document.querySelector('.search-button').addEventListener('click', function() {
    const searchBox = document.getElementById('searchBox');
    searchBox.classList.toggle('open'); // Toggle the 'open' class to show/hide
});
document.querySelector('.search-button').addEventListener('click', function() {
    const searchBox = document.getElementById('searchBox');
    searchBox.classList.toggle('open');
});
document.querySelector('.calculate-button').addEventListener('click', () => {
    const startLocation = document.querySelector('.location-input:nth-of-type(1)').value;
    const destination = document.querySelector('.location-input:nth-of-type(2)').value;
    const car = document.querySelector('.search-container input[type="search"]').value;
    const mileage = 15; // Replace with actual mileage
    const people = document.querySelector('.people-selection .active').textContent;

    // Calculate total cost logic here (replace with your calculation)
    const totalCost = 100; // Dummy cost value, replace with actual calculation

    // Store data in local storage
    localStorage.setItem('startLocation', startLocation);
    localStorage.setItem('destination', destination);
    localStorage.setItem('car', car);
    localStorage.setItem('mileage', mileage);
    localStorage.setItem('people', people);
    localStorage.setItem('totalCost', totalCost);

    // Redirect to trip details page
    window.location.href = 'trip-details.html'; // Replace with the correct path to the second page
});
document.getElementById("tripForm").addEventListener("submit", function(event) {
    event.preventDefault(); // Prevent the form from submitting the default way

    const startingPoint = document.getElementById("startingPoint").value;
    const destination = document.getElementById("destination").value;
    const numberOfPeople = document.getElementById("numberOfPeople").value;

    // Fetch trip cost
    fetch(`/calculateTrip?startingPoint=${startingPoint}&destination=${destination}&numberOfPeople=${numberOfPeople}`)
        .then(response => response.json())
        .then(data => {
            document.getElementById("tripCost").innerText = data.cost; // Assuming your Trip model has a 'cost' field

            // Fetch route details
            return fetch(`/route?startingPoint=${startingPoint}&destination=${destination}`);
        })
        .then(response => response.json())
        .then(routeData => {
            const routeDetailsElement = document.getElementById("routeDetails");
            routeDetailsElement.innerHTML = ""; // Clear previous route details

            routeData.forEach(route => {
                const li = document.createElement("li");
                li.innerText = route; // Adjust based on your response format
                routeDetailsElement.appendChild(li);
            });
        })
        .catch(error => {
            console.error("Error:", error);
        });
});
