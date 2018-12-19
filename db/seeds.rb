require 'json'
require 'rest-client'

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

# Seeding users
puts "=========Creating Users========"
  User.create(
    username: "FedM",
    description: "Loves cocktails",
    photo: "akjhhd",
    email: "fed123@mistercocktail.com",
    encrypted_password: '123456'
  )

# Seeding cocktails
puts "=========Saving Cocktails=========="
response = RestClient.get('https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Ordinary_Drink')
drinks = JSON.parse(response.body)['drinks']

drinks.first(10).each do |drink|
  id = drink['idDrink']
  response = RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{id}")
  drinks = JSON.parse(response.body)['drinks'][0]

  Cocktail.create!(name: drinks['strDrink'], description: drinks['strCategory'], remote_photo_url: drinks['strDrinkThumb'], user: User.first)
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
