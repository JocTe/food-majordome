class MenusController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :save_to_session ]
  skip_after_action :verify_authorized
  before_action :set_user, only: [:show]
  before_action :set_menu, only: [:show]

  def new
    # policy_scope(Recipe)
    @menu = Menu.new
    preferences = session["preferences"]
    if preferences["vegan"]
      preferences["vegetarian"] = true
      preferences["dairy_free"] = true      
    end    

    matching_recipes = Recipe.where(dairy_free: preferences["dairy_free"],
      vegetarian: preferences["vegetarian"], gluten_free: preferences["gluten_free"])
    
    recipes_by_name = matching_recipes.group_by { |recipe| recipe.name }

    uniq_recipes_selection = []
    recipes_by_name.each_value do |value|
      uniq_recipes_selection << value[0]
    end

    @suggestions = uniq_recipes_selection.sample(5)

    authorize @menu
  end

  def save_to_session
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
    @menu = Menu.last
    authorize @menu
  end
end
