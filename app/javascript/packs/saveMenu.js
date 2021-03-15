import { fetchWithToken } from "../utils/fetch_with_token";


const initSaveMenu = () => {

    const save = (event) => {
        event.preventDefault();
        const recipes = document.querySelectorAll(".menu-card");
        const body = {};
        const recipes_data = {};
        recipes_data["recipes_data"] = []
        recipes.forEach(recipe => {
            recipes_data[`recipes_data`].push({ "recipe_id": recipe.dataset.recipeId, "date": recipe.dataset.recipeDate }); // I want a hash recipes that store other hashes recipe

        });

        fetchWithToken('/save_session', {
            method: "POST",
            redirect: "follow",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            body: JSON.stringify(recipes_data)
        })
            .then(response => response.json())
            .then((data) => {
                document.location.href = "/shoppinglist";
                console.log(data)
            })
    };

    const button = document.querySelector(".save-btn-menu");

    if (button) {
        button.addEventListener('click', save);
    }
};

export { initSaveMenu };