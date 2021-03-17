class MenusController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :save_to_session ]
  skip_after_action :verify_authorized
  before_action :set_user, only: [:show]
  before_action :set_menu, only: [:show]

  def new
    # policy_scope(Recipe)
    @menu = Menu.new

    preferences = session["preferences"]
    possible_recipes = []

    case session["preferences"]
      when preferences["vegan"] = true && preferences["gluten_free"] = true && preferences["dairy_free"] = true
        possible_recipes << Recipe.where(vegan: true, gluten_free: true, dairy_free: true, vegetarian: true)
      when preferences["vegetarian"] = true && preferences["gluten_free"] = true && preferences["dairy_free"] = true
        possible_recipes << Recipe.where(vegetarian: true, gluten_free: true, dairy_free: true)
      when preferences["vegan"] = true && preferences["gluten_free"] = true
        possible_recipes << Recipe.where(vegan: true, gluten_free: true, vegetarian: true)
      when preferences["vegan"] = true && preferences["dairy_free"] = true
        possible_recipes << Recipe.where(vegan: true, dairy_free: true, vegetarian: true)
      when preferences["vegetarian"] = true && preferences["gluten_free"] = true
        possible_recipes << Recipe.where(vegetarian: true, gluten_free: true)
      when preferences["vegetarian"] = true && preferences["dairy_free"] = true
        possible_recipes << Recipe.where(vegetarian: true, dairy_free: true)
      when preferences["vegan"] = true
        possible_recipes << Recipe.where(vegan: true, vegetarian: true)
      when preferences["vegetarian"] = true
        possible_recipes << Recipe.where(vegetarian: true)
      when preferences["gluten_free"] = true && preferences["dairy_free"] = true
        possible_recipes << Recipe.where(gluten_free: true, dairy_free: true)
      when preferences["gluten_free"] = true
        possible_recipes << Recipe.where(gluten_free: true)
      when preferences["dairy_free"] = true
        possible_recipes << Recipe.where(dairy_free: true)
      else
       possible_recipes << Recipe.all
    end

    recipes_by_name = possible_recipes.flatten.group_by { |recipe| recipe.name }

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
end
