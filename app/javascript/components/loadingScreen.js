import Typed from 'typed.js';



const loadingScreenTyped = () => {
    const loadingText = document.getElementById("loading-title");


    var options = {
        strings: ['Recolting fresh <strong>ingredients</strong>^650 ', 'Filling your shopping list^650', 'Getting our hands <i>dirty</i>^650'],
        typeSpeed: 40,
        cursorChar: '',
        fadeOut: true,
        loop: true
    };


    if (loadingText) {
        new Typed(loadingText, options);
    }
}

export { loadingScreenTyped };
