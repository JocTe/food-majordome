# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




def fetchRecipes(args = {})
    amount = args[:amount]
    api_key = ENV['SPOONACULAR_KEY']
    url = "https://api.spoonacular.com/recipes/random?apiKey=#{api_key}&number=#{amount}"
    recipes_serialized = open(url).read
    recipes = JSON.parse(recipes_serialized)
end

Recipe.create!(servings: 2, prep_time:20, score:63.2, health_score:68, calories: 564, name: "Test", summary: "This is a test recipe", image:"https://spoonacular.com/cdn/ingredients_100x100/pineapple.jpg", cheap: true, dairy_free: true, gluten_free: false, vegan: false, vegetarian: false, healthy: true, pescetarian: true, cuisine: "French", author: "me", spoonacular_id:5665)



