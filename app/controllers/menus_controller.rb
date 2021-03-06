class MenusController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :save_to_session ]
  skip_after_action :verify_authorized
  before_action :set_user, only: [:show]
  before_action :set_menu, only: [:show]

  def new
    # policy_scope(Recipe)
      @menu = Menu.new
      
      preferences = session["preferences"]
      matching_recipes = recipes_matching_preferences(preferences)
      recipes_by_name = matching_recipes.flatten.group_by { |recipe| recipe.name }

      uniq_recipes_selection = []
      recipes_by_name.each_value do |value|
        uniq_recipes_selection << value[0]
      end

      result = uniq_recipes_selection.sample(20)
      @suggestions = result.each_slice(4).to_a

      authorize @menu
    
  end

  def save_to_session
    if user_signed_in?
      current_user.menus.destroy_all
    end
  session["recipes_data"] = params["recipes_data"]
  render json: session["recipes_data"].to_json
  end

  def show
    @menuplans = @menu.menu_plans

  end

  private
  def set_user
    @user = current_user
  end

  def set_menu
    @menu = current_user.menus.last
    authorize @menu
  end

  def recipes_matching_preferences(preferences)
    possible_recipes = []

    if preferences["vegan"] == true
      if preferences["gluten_free"] == true && preferences["dairy_free"] == true
        possible_recipes << Recipe.where(vegan: true, gluten_free: true, dairy_free: true, vegetarian: true)
      elsif preferences["gluten_free"] == true
        possible_recipes << Recipe.where(vegan: true, gluten_free: true, vegetarian: true)
      elsif preferences["dairy_free"] == true
        possible_recipes << Recipe.where(vegan: true, dairy_free: true, vegetarian: true)
      else
        possible_recipes << Recipe.where(vegan: true, vegetarian: true)        
      end
    end

    if preferences["vegetarian"] == true
      if preferences["gluten_free"] == true && preferences["dairy_free"] == true
        possible_recipes << Recipe.where(vegetarian: true, gluten_free: true, dairy_free: true)
      elsif preferences["dairy_free"] == true
        possible_recipes << Recipe.where(vegetarian: true, dairy_free: true)
      elsif preferences["gluten_free"] == true
        possible_recipes << Recipe.where(vegetarian: true, gluten_free: true)
      else
        possible_recipes << Recipe.where(vegetarian: true)        
      end
    end

    if preferences["gluten_free"] == true && preferences["vegan"] == false && preferences["vegetarian"] == false
      if preferences["dairy_free"] == true
        possible_recipes << Recipe.where(gluten_free: true, dairy_free: true)
      else
        possible_recipes << Recipe.where(gluten_free: true)
      end
    end

    if preferences["dairy_free"] == true && preferences["gluten_free"] == false && preferences["vegan"] == false && preferences["vegetarian"] == false
      possible_recipes << Recipe.where(dairy_free: true)
    end

    if preferences["no_diet"] == true
      possible_recipes << Recipe.all
    end    

    return possible_recipes

  end

end
