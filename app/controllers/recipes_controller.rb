class RecipesController < ApplicationController

    def create
        recipe = Recipe.new(recipe_params)
        
        # authorize @recipe 
        if recipe.save
            render json: { success: true }
        else
            render json: { success: false, errors: recipe.errors.messages }, status: :unprocessable_entity 
        end
    end

    private

    def recipe_params
    params.require(:recipe).permit(:servings, :prep_time, :score, :health_score, :name, :summary,
        :image, :cheap, :dairy_free, :gluten_free, :vegan, :vegetarian, :healthy)
    end

end
