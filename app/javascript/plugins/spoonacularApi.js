import { fetchWithToken } from "../utils/fetch_with_token";

const apiKey = process.env.SPOONACULAR_KEY;

const fetchMenuRecipes = () => {
    const results = document.getElementById("recipes");

    if (results) {
        fetch(`https://api.spoonacular.com/recipes/random?apiKey=${apiKey}&number=1`)
            .then(response => response.json())
            .then((data) => {

                data.recipes.forEach(result => {

                    // console.log(result);
                    const recipeTag = `<li class="recipe">
                    <p>${result.title}</p>
                    </li>`;
                    results.insertAdjacentHTML('beforeend', recipeTag);

                    const body = {
                        recipe: {
                            servings: result.servings, prep_time: result.readyInMinutes, score: result.spoonacularScore, health_score: result.healthScore, name: result.title, summary: result.summary,
                            image: result.image, cheap: result.cheap, dairy_free: result.dairyFree, gluten_free: result.glutenFree, vegan: result.vegan, vegetarian: result.vegetarian, healthy: result.veryHealthy
                        }
                    }
                    console.log(body);

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
            });
    }
};

export { fetchMenuRecipes };