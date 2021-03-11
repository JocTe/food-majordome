class MenusController < ApplicationController
    skip_before_action :authenticate_user!, only: [ :new ]

    def new
      @menu = Menu.new
      @suggestions = Recipe.last(5) # where preferences match get last 5
      authorize @menu 
    end

    def create
      # how do i assign a user to menu if I don't have one

      

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
