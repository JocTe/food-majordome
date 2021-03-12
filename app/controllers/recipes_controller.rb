class RecipesController < ApplicationController  
  skip_before_action :authenticate_user!, only: [ :show ]

  def show    
    @recipe = Recipe.find(params[:id])
    authorize @recipe
  end
end
