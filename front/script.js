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
