class UserIngredientsController < ApplicationController
  
  skip_before_action :authenticate_user!, only: [ :index ] # TO DELET LOOK AT PUNDIT SCOPE
  skip_after_action :verify_authorized

  def index
    @menu = current_user.menus.empty? ? create_menu : current_user.menus.last
    # //? How should I work it here - There is multipe proportion for one ingredient
    # //? Also how do I take the unit should I make a request call to the api to convert them?
    # //? GET https://api.spoonacular.com/recipes/{id}/ingredientWidget.json

    @menu.recipes.each do |recipe|
      recipe.ingredients.each do |ingredient|
    # //! ITERATE ON THE PROPORTIONS INSTEAD OF INGREDIENT, THEN ADD INGREDIENTS TOGETHER, THEN COMBINE EVERY INGREDIents
    # //! add each found ingredients in recipes to an array, combines the same ingredients together BUT how do I get the proportions?
        create_user_ingredients(ingredient, recipe)
      end
    end

    @user_ingredients = policy_scope(UserIngredient) # //TODO CHANGE CHECK POLICYSCOPE
    
    # @ingredients = UserIngredient.all
  end



  private

  def create_user_ingredients(ingredient, recipe)

    if UserIngredient.find_by(ingredient_id: ingredient.id).nil?
      
      # //! Proportion.where(ingredient_id: 1865, recipe_id:1236).group(:ingredient).sum(:amount) group by ingredients
      sum_amounts = Proportion.where(ingredient:ingredient, recipe: recipe).sum(:amount)
      user_ingredient = UserIngredient.create(status: false, quantity: sum_amounts, user: current_user, ingredient: ingredient)
    else
      sum_amounts = Proportion.where(ingredient:ingredient, recipe: recipe).sum(:amount)
      user_ingredient = UserIngredient.find_by(ingredient_id: ingredient.id)
     
      user_ingredient.update(quantity: user_ingredient.quantity.to_f + sum_amounts ) #//? maybe change quantity to a float
    
    end   
  end

  def join_ingredients_doubles(list_of_ingredients)
    #//! here check if doubles
      # join doubles ingredient
    # return a list of ingredients with their amount and unit
  end

  def create_menu
    @menu = Menu.new
    @menu.user = current_user
    session["recipes_data"].each do |recipe|
      menu_plan = MenuPlan.new(date: recipe["date"])
      menu_plan.recipe = Recipe.find(recipe["recipe_id"])
      menu_plan.menu = @menu
      menu_plan.save
    end
    @menu.save
    @menu
  end

end
