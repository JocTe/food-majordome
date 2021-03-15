class MenusController < ApplicationController
    skip_before_action :authenticate_user!, only: [ :new, :save_to_session ]
    skip_after_action :verify_authorized
   
    def new
      # policy_scope(Recipe)
      @menu = Menu.new
      preferences = session["preferences"] 
      if preferences["vegan"]
        preferences["vegetarian"] = true
        preferences["dairy_free"] = true
        preferences["gluten_free"] = true
      end
      
      @suggestions = Recipe.where(dairy_free: preferences["dairy_free"], vegan: preferences["vegan"], 
        vegetarian: preferences["vegetarian"], gluten_free: preferences["gluten_free"]).first(5) # where preferences match get last 5

      authorize @menu 
    end

  

    def save_to_session
    session["recipes_data"] = params["recipes_data"]
    render json: session["recipes_data"].to_json 
    end

end
