class MenusController < ApplicationController
  require 'json'
  require 'open-uri'

    def new
      @menu = Menu.new()
      @suggestions = Recipe.all.sample(5)
    end


    private

    
end
