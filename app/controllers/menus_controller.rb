class MenusController < ApplicationController
    skip_before_action :authenticate_user!, only: [ :new ]

    def new
        @menu = Menu.new
        @suggestions = Recipe.last(5) # where preferences match get last 5
        authorize @menu
    end

end
