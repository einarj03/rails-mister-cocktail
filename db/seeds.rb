# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Ingredient.create(name: "lemon")
# Ingredient.create(name: "ice")
# Ingredient.create(name: "mint leaves")

Ingredient.destroy_all
Cocktail.destroy_all
Dose.destroy_all

ingredient_url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
serialized_ingredients = open(ingredient_url).read
ingredients = JSON.parse(serialized_ingredients)
ingredients["drinks"].each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
end

cocktail_url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
cocktail_names = %w[margarita mojito cosmopolitan]
cocktail_names.each do |name|
  serialized_cocktail = open("#{cocktail_url}#{name}").read
  cocktail = JSON.parse(serialized_cocktail)['drinks'].first
  Cocktail.create(name: cocktail['strDrink'])
  ingredient = Ingredient.find_by(name: cocktail['strIngredient1'])
  # Cocktail.last.add_ingredient(ingredient)
  Dose.create(description: cocktail["strMeasure1"], cocktail: Cocktail.last, ingredient: ingredient)
end
