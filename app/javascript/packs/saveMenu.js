import { fetchWithToken } from "../utils/fetch_with_token";


const initSaveMenu = () => {

    const save = (event) => {
        event.preventDefault();
        const recipes = document.querySelectorAll(".menu-card");
        recipes.forEach(recipe => {
            console.log(recipe.dataset.recipeId);
            const body = {
                "recipe_id": recipe.dataset.recipeId
            }
            console.log(body)
            fetchWithToken('/menus', {
                method: "POST",
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(body)
            })
                .then(response => response.json())
                .then((data) => {
                    console.log(data)
                })

        });
    };

    const button = document.querySelector(".save-btn-menu");

    if (button) {
        button.addEventListener('click', save);
    }
};

export { initSaveMenu };