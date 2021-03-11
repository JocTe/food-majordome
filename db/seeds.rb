# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "creating recipe"
recipe = Recipe.create!(servings: 4, prep_time:45, score:63.2, health_score:68, calories: 564, name: "Croque Monsieur", summary: "Jelly I love cookie croissant halvah lollipop pudding brownie. Jujubes cake bonbon topping halvah muffin I love I love. Gummies I love caramels gingerbread icing tart dessert pie. Marzipan cookie cotton candy. Caramels tart cheesecake. Chocolate cake gingerbread candy sugar plum. Marshmallow muffin jelly-o jelly-o. Croissant topping lemon drops biscuit sesame snaps cookie chocolate cake bear claw jelly beans. Marzipan donut gummi bears macaroon biscuit dessert pastry gummi bears.", 
                image:"https://assets.afcdn.com/recipe/20170112/28965_w157h157c1.webp", cheap: true, dairy_free: true, gluten_free: true, vegan: true, vegetarian: true, healthy: true, 
                pescetarian: true, cuisine: "French", author: "Favot Original", user_id: 1)


ingredients = ["sel", "muscade", "jambon", "pain de mie", "beurre tendre", "toastinette", "gruyère rapé", "lait", "poivre"]
ingredients.each do |ingredient|
  Ingredient.create!(name: "#{ingredient}")  
end

# proportions
puts "creating proportions"

Proportion.create!(ingredient_id: 2, recipe_id: 1, amount: 1, unit: "pincée")
Proportion.create!(ingredient_id: 3, recipe_id: 1, amount: 4, unit: "tranches")
Proportion.create!(ingredient_id: 4, recipe_id: 1, amount: 8, unit: "tranches")
Proportion.create!(ingredient_id: 5, recipe_id: 1, amount: 50, unit: "g")
Proportion.create!(ingredient_id: 6, recipe_id: 1, amount: 4, unit: "tranches")
Proportion.create!(ingredient_id: 7, recipe_id: 1, amount: 100, unit: "g")
Proportion.create!(ingredient_id: 8, recipe_id: 1, amount: 4, unit: "cs")

# steps
puts "creating setps"

Step.create!(recipe_id: 1,number: 1, description: "Beurrez les 8 tranches de pain de mie sur une seule face. Posez 1 tranche de fromage sur chaque tranche de pain de mie. Posez 1 tranche de jambon plié en deux sur 4 tranches de pain de mie. Recouvrez avec les autres tartines (face non beurrée au dessus).")
Step.create!(recipe_id: 1,number: 2, description: "Dans un bol mélanger le fromage râpé avec le lait, le sel, le poivre et la muscade.")
Step.create!(recipe_id: 1,number: 3, description: "Répartissez le mélange sur les croque-monsieur.")
Step.create!(recipe_id: 1,number: 4, description: "Placez sur une plaque au four sous le grill pendant 10 mn.")
