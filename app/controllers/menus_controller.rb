class MenusController < ApplicationController
    skip_before_action :authenticate_user!, only: [ :new ]

    def new
      @menu = Menu.new
      preferences = session["preferences"] 
      if preferences["vegan"]
        preferences["vegetarian"] = true
        preferences["dairy_free"] = true
        preferences["gluten_free"] = true
      end
      
      @suggestions = Recipe.where(dairy_free: preferences["dairy_free"], vegan: preferences["vegan"], 
        vegetarian: preferences["vegetarian"], gluten_free: preferences["gluten_free"]).first(5) # where preferences match get last 5
      session["recipe_data"] = [{}]
      authorize @menu 
    end

    def create

      recipe_data = session["recipe_data_0"]
      params["recipe_data_0"].each do |key, value|
        if recipe_data.key?(key)
          recipe_data[key] = value
        end
      end
      

     render json: session["recipe_data"].to_json

      # how do i assign a user to menu if I don't have one

      # check if user is sign in, if not store recipe_info into the session
       # then create the menu on the dashboard

      # menu_plan = MenuPlan.new()
      # menu_plan.menu = @menu
      # menu_plan.recipe = Recipe.find(params["recipe_id"])
      # # i need a date
      # if menu_plan.save
      #   redirect_to root_path
      # else
      #   render :new
      # end
    end

end
