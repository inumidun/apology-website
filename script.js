let currentPage = 1;
const totalPages = 4;

function nextPage() {
    if (currentPage < totalPages) {
        document.getElementById(`page${currentPage}`).classList.remove('active');
        currentPage++;
        document.getElementById(`page${currentPage}`).classList.add('active');
    }
}

function prevPage() {
    if (currentPage > 1) {
        document.getElementById(`page${currentPage}`).classList.remove('active');
        currentPage--;
        document.getElementById(`page${currentPage}`).classList.add('active');
    }
}

// Add floating petals dynamically
function createFloatingPetals() {
    const petalsContainer = document.querySelector('.petals');
    const petalEmojis = ['🌸', '🌺', '💗', '🌷'];
    
    for (let i = 0; i < 15; i++) {
        const petal = document.createElement('div');
        petal.style.position = 'absolute';
        petal.style.fontSize = Math.random() * 15 + 15 + 'px';
        petal.style.left = Math.random() * 100 + '%';
        petal.style.top = Math.random() * 100 + '%';
        petal.style.opacity = Math.random() * 0.3 + 0.2;
        petal.textContent = petalEmojis[Math.floor(Math.random() * petalEmojis.length)];
        petal.style.animation = `float ${Math.random() * 10 + 10}s infinite`;
        petal.style.animationDelay = Math.random() * 5 + 's';
        petalsContainer.appendChild(petal);
    }
}

// Initialize on page load
window.addEventListener('load', createFloatingPetals);
