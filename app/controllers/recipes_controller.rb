class RecipesController < ApplicationController  
  def show    
    @recipe = Recipe.find(1)
    authorize @recipe
  end
end
