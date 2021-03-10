
const apiKey = process.env.SPOONACULAR_KEY;

const fetchMenuRecipes = () => {
    const results = document.getElementById("recipes");

    if (results) {
        fetch(`https://api.spoonacular.com/recipes/random?apiKey=${apiKey}&number=1`)
            .then(response => response.json())
            .then((data) => {

                data.recipes.forEach(result => {

                    const recipeTag = `<li class="recipe">
                        <p>${result.title}</p>
                        <div class="recipe-params" data-id="${result.id}" data-servings="${result.servings}" data-prep-time="${result.readyInMinutes}" 
                            data-score="${result.spoonacularScore}" data-health-score ="${result.healthScore}" data-name="${result.title}" 
                            data-image="${result.image}" data-cheap="${result.cheap}" data-dairy-free="${result.dairyFree}" data-gluten-free="${result.glutenFree}" 
                            data-vegan="${result.vegan}" data-vegetarian="${result.vegetarian}" data-healthy="${result.veryHealthy}" data-summary="${result.summary.split(".")[0]}">
                        </div>
                    </li>`;

                    results.insertAdjacentHTML('beforeend', recipeTag);
                    const recipe = document.querySelector(".recipe-params");
                    console.log(recipe);
                });
            });

    }
};



export { fetchMenuRecipes };