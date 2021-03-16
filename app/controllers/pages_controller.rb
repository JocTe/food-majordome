class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :preferences, :submit_preferences ]

  def home
  end

  def dashboard
    @user = current_user
    @menu = Menu.last
    authorize @menu
    @menuplans = @menu.menu_plans
  end

  def preferences
    session["preferences"] = { number_of_people: 1, vegan: false, vegetarian: false, gluten_free: false, dairy_free: false, pescetarian: false, no_diet: false, ingredients_disliked: [], ingredients_wanted: [] }
  end

  def submit_preferences
  
    
    preferences = session["preferences"]
    params["preferences"].each do |key, value|
      if preferences.key?(key)
        preferences[key] = value
      end
    end

    if user_signed_in?
      current_user.menus.destroy_all
      preferences = session["preferences"]
      current_user.update(number_of_people: preferences["number_of_people"], vegan: preferences["vegan"], vegetarian: preferences["vegetarian"],  gluten_free: preferences["gluten_free"], dairy_free: preferences["dairy_free"], pescetarian: preferences["pescetarian"], no_diet: preferences["no_diet"])
    end
    # enregistrer les infos dans la session
    # updtater les preferences
    render json: session["preferences"].to_json
  end

end
