import Typed from 'typed.js';



const loadingScreenTyped = () => {
    const loadingText = document.getElementById("loading-title");
    var options = {
        strings: ['Recolting fresh <strong>ingredients</strong>', 'Getting our hands dirty'],
        typeSpeed: 40,
        cursorChar: '',
        loop: true
    };

    if (loadingText) {
        var typed = new Typed(loadingText, options);
    }
}

export { loadingScreenTyped };
