class UserIngredientsController < ApplicationController
   require 'open-uri'
   require 'json'
   # TO DELET LOOK AT PUNDIT SCOPE

  def index
    save_user_pref(current_user)
    @menu = current_user.menus.empty? ? create_menu : current_user.menus.last 
    
    if current_user.user_ingredients.count == 0 
      @menu.recipes.each do |recipe|
        recipe.ingredients.each do |ingredient|
        create_user_ingredients(ingredient, recipe)
        end
      end
    end

    @user_ingredients = policy_scope(current_user.user_ingredients) 

  end



  private

  def save_user_pref(user)
    preferences = session["preferences"]
    user.update(number_of_people: preferences["number_of_people"], vegan: preferences["vegan"], vegetarian: preferences["vegetarian"],  gluten_free: preferences["gluten_free"], dairy_free: preferences["dairy_free"], pescetarian: preferences["pescetarian"], no_diet: preferences["no_diet"])
  end


  def create_user_ingredients(ingredient, recipe)

    if UserIngredient.find_by(ingredient_id: ingredient.id, user_id: current_user.id).nil?
     
      amount = convert_to_gram(ingredient, recipe)
      user_ingredient = UserIngredient.create(status: false, quantity: amount, user: current_user, ingredient: ingredient)
    else
     
      amount = convert_to_gram(ingredient, recipe)
      user_ingredient = UserIngredient.find_by(ingredient_id: ingredient.id, user_id: current_user.id)
     
      user_ingredient.update(quantity: user_ingredient.quantity.to_f + amount )
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
  
  end

  def create_menu
    current_user.user_ingredients.destroy_all 
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
