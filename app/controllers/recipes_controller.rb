class RecipesController < ApplicationController  
  skip_before_action :authenticate_user!, only: [ :show, :instructions ]
  # delete :instruction when we can attribute teh recipe to the user

  def show    
    @recipe = Recipe.find(params[:id])
    authorize @recipe
  end

  def instructions
    @recipe = Recipe.find(params[:id])
    # delete the following line when we can attribute the recipe to the user:
    authorize @recipe
  end
end
