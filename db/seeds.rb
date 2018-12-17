require 'open-uri'
require 'json'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
# json = open(url).read
# ingredients = JSON.parse(json)

# ingredients.each do |ingredient|
#   Ingredient.create(name: ingredient["strIngredient1"])
# end

# Destroying old database
puts "=========Destroying Old Cocktails and Ingredients==========="
Cocktail.destroy_all
Ingredient.destroy_all

# Seeding cocktails
puts "=========Saving Cocktails=========="
url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Ordinary_Drink'
drinks_serialized = open(url).read
drinks = JSON.parse(drinks_serialized)['drinks']

drinks.first(10).each do |drink_id|
  url = 'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{drink_id}'
  encoded_url = URI.encode(url)
  drinks_serialized = open(encoded_url).read
  drinks = JSON.parse(drinks_serialized)

  Cocktail.create(name: drinks[:strDrink], description: drinks[:strIBA], photo: drinks[:strDrinkThumb])
end

# Seeding Ingredients
puts "========Saving Ingredients============"
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

puts "===========New Database Seeded Successfully==============="
