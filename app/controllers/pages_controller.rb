class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :preferences, :submit_preferences ]

  def home
  end

  def dashboard
    @user = current_user
  end

  def preferences
    session["preferences"] = { number_of_people: 1, vegan: false, vegetarian: false, gluten_free: false, dairy_free: false, pescetarian: false, no_diet: false, ingredients_disliked: [], ingredients_wanted: [] }
  end

  def submit_preferences
    Menu.destroy_all # Quick fix for shoppinglist
    preferences = session["preferences"]
    params["preferences"].each do |key, value|
      if preferences.key?(key)
        preferences[key] = value
      end
    end
    # enregistrer les infos dans la session
    # updtater les preferences
    render json: session["preferences"].to_json
  end

end
