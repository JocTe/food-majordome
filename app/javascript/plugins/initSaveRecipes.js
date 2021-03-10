import { fetchWithToken } from "../utils/fetch_with_token";


const initSaveRecipes = () => {

    const save = (event) => {
        event.preventDefault();
        const recipes = document.querySelectorAll(".recipe-params");
        recipes.forEach(recipe => {

            const body = {
                recipe: {
                    servings: recipe.dataset.servings, prep_time: recipe.dataset.prepTime, score: recipe.dataset.score, health_score: recipe.dataset.healthScore, name: recipe.dataset.name, summary: recipe.dataset.summary,
                    image: recipe.dataset.image, cheap: recipe.dataset.cheap, dairy_free: recipe.dataset.dairyFree, gluten_free: recipe.dataset.glutenFree, vegan: recipe.dataset.vegan, vegetarian: recipe.dataset.vegetarian, healthy: recipe.dataset.healthy
                }
            }

            fetchWithToken('/recipes', {
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

    const button = document.querySelector(".save-btn-recipes");
    button.addEventListener('click', save);
};

export { initSaveRecipes };