require 'open-uri'
require 'JSON'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
json = open(url).read
ingredients = JSON.parse(json)

ingredients.each do |ingredient|
  ingredient = ingredient["strIngredient1"]
end

Ingredient.create(name: "lemon")
Ingredient.create(name: "lime")
Ingredient.create(name: "ice")
Ingredient.create(name: "tonic")
Ingredient.create(name: "pineapple juice")
Ingredient.create(name: "orange juice")
Ingredient.create(name: "fruit punch")
Ingredient.create(name: "mint leaves")
Ingredient.create(name: "rum")
Ingredient.create(name: "gin")
Ingredient.create(name: "tequila")
Ingredient.create(name: "vodka")
Ingredient.create(name: "whiskey")
Ingredient.create(name: "champange")

