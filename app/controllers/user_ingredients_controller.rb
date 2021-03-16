class UserIngredientsController < ApplicationController
   require 'open-uri'
   require 'json'
   # TO DELET LOOK AT PUNDIT SCOPE

  def index
    save_user_pref(current_user)
    @menu = current_user.menus.empty? ? create_menu : current_user.menus.last #//? maybe check if it's the same menu than session
    # //? How should I work it here - There is multipe proportion for one ingredient
    # //? Also how do I take the unit should I make a request call to the api to convert them?
    # //? GET https://api.spoonacular.com/recipes/{id}/ingredientWidget.json
    if UserIngredient.count == 0 # //* This check if the shopping list is empty - The menu don't change now, because I need to destroy the shopping list when a new menu is made
      @menu.recipes.each do |recipe|
        recipe.ingredients.each do |ingredient|
      # //! ITERATE ON THE PROPORTIONS INSTEAD OF INGREDIENT, THEN ADD INGREDIENTS TOGETHER, THEN COMBINE EVERY INGREDIents
      # //! add each found ingredients in recipes to an array, combines the same ingredients together BUT how do I get the proportions?
          create_user_ingredients(ingredient, recipe)
        end
      end
    end

    @user_ingredients = policy_scope(UserIngredient) # //TODO CHANGE CHECK POLICYSCOPE
    
    # @ingredients = UserIngredient.all
  end



  private

  def save_user_pref(user)
    preferences = session["preferences"]
    user.update(number_of_people: preferences["number_of_people"], vegan: preferences["vegan"], vegetarian: preferences["vegetarian"],  gluten_free: preferences["gluten_free"], dairy_free: preferences["dairy_free"], pescetarian: preferences["pescetarian"], no_diet: preferences["no_diet"])
  end

  # //! SHould only be called once by menu
  def create_user_ingredients(ingredient, recipe)

    if UserIngredient.find_by(ingredient_id: ingredient.id).nil?
      
      # //! Proportion.where(ingredient_id: 1865, recipe_id:1236).group(:ingredient).sum(:amount) group by ingredients
      #amount = Proportion.where(ingredient:ingredient, recipe: recipe).sum(:amount)
     
      amount = convert_to_gram(ingredient, recipe)
      user_ingredient = UserIngredient.create(status: false, quantity: amount, user: current_user, ingredient: ingredient)
    else
      # amount = Proportion.where(ingredient:ingredient, recipe: recipe).sum(:amount)
      amount = convert_to_gram(ingredient, recipe)
      user_ingredient = UserIngredient.find_by(ingredient_id: ingredient.id)
     # //! ISSUE : This add an amount each time I go to the shopping list and shopping list is slow.
      user_ingredient.update(quantity: user_ingredient.quantity.to_f + amount ) #//? maybe change quantity to a float
    end   
  end

  def convert_to_gram(ingredient, recipe)
    proportions = Proportion.where(ingredient:ingredient, recipe: recipe)
    amount = []
    proportions.each do |proportion| 
      url = "https://api.spoonacular.com/recipes/convert?apiKey=#{ENV['SPOONACULAR_KEY']}&ingredientName=#{ingredient.name}&sourceAmount=#{proportion.amount}&sourceUnit=#{proportion.unit}&targetUnit=grams"
      serialized_conversion = open(url).read
      conversion = JSON.parse(serialized_conversion)
      amount << conversion['targetAmount'].to_f
    end
    amount.inject(0){|sum,x| sum + x }
    # retrun amount in gram
  end

  def create_menu
    current_user.user_ingredients.destroy_all # //! This destroy all the shopping list because you create a menu
    # current_user.update(number_of_people: session[""])
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
