class MenusController < ApplicationController
  require 'json'
  require 'open-uri'

    def new
      @menu = Menu.new()
    end


    private

    def fetchRecipes(amount)
      api_key = ENV['SPOONACULAR_KEY']
      url = "https://api.spoonacular.com/recipes/random?apiKey=#{api_key}&number=#{amount}"
      recipes_serialized = open(url).read
      recipes = JSON.parse(recipes_serialized)
      recipes.each do |recipe|
        recipes[0].summary
      end
    end
end
