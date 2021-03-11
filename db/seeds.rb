# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'



def fetch_recipes_api(args = {})
    amount = args[:amount]
    diet = args[:diet]
    api_key = ENV['SPOONACULAR_KEY']
    url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=#{api_key}&diet=#{diet}&instructionsRequired=true&addRecipeInformation=true&addRecipeNutrition=true&ignorePantry=true&sort=meta-score&sortDirection=desc&type=main course,salad,soup,side dish&number=#{amount}"
    recipes_serialized = open(url).read
    recipes = JSON.parse(recipes_serialized)
    recipes["results"]
end

def creating_steps_of_recipe(recipe_json, recipe)
    recipe_json.each do |step|
       image = step["equipment"].empty? ? "test" : step["equipment"][0]["image"]
        p image
        new_step = Step.new(number: step["number"], description: step["step"], image: image)
        new_step.recipe = recipe
        new_step.save
    end
end
# puts JSON.pretty_generate(fetch_recipes_api({amount: 2, diet: "vegetarian"}))

def create_recipes_and_associations(args = {})

    fetch_recipes_api(args).each do |recipe|
        puts "Creating Recipe name : #{recipe["title"]}"
        new_recipe = Recipe.create!(servings: recipe["servings"], prep_time: recipe["readyInMinutes"], score: recipe["spoonacularScore"],
            health_score: recipe["healthScore"], calories: recipe["nutrition"]["nutrients"][0]["amount"], name: recipe["title"], 
            summary: recipe["summary"], image: recipe["image"], cheap: recipe["cheap"], dairy_free: recipe["dairyFree"], gluten_free: recipe["glutenFree"],
            vegan: recipe["vegan"], vegetarian: recipe["vegetarian"], healthy: recipe["veryHealthy"], cuisines: recipe["cuisines"], diets: recipe["diets"], 
            author: recipe["creditsText"], spoonacular_id: recipe["id"]
            )
        puts "--------------------------------------------------------------"

        puts "Creating Steps for : #{recipe["title"]}"

        creating_steps_of_recipe(recipe["analyzedInstructions"][0]["steps"], new_recipe)

        puts "Steps done"

        puts "-----------------------------------------------------------------"


        puts "Creating Ingredients"

        recipe["nutrition"]["ingredients"].each do |ingredient|
            # check if ingredient exist in the database
            if Ingredient.find_by(name: ingredient["name"])
                i = Ingredient.find_by(name: ingredient["name"])
            else
                i = Ingredient.create!(name: ingredient["name"], image: "#{ingredient["name"]}.jpg")
            end
            proportion = Proportion.new(unit: ingredient["unit"], amount: ingredient["amount"])
            proportion.recipe = new_recipe
            proportion.ingredient = i
            proportion.save!
        end
    end
end




create_recipes_and_associations(amount: 1, diet: "vegetarian")

# Recipe.create!(servings: 2, prep_time:20, score:63.2, health_score:68, calories: 564, name: "Test", summary: "This is a test recipe", image:"https://spoonacular.com/cdn/ingredients_100x100/pineapple.jpg", cheap: true, dairy_free: true, gluten_free: false, vegan: false, vegetarian: false, healthy: true, pescetarian: true, cuisine: "French", author: "me", spoonacular_id:5665)



