class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  validates :name, presence: true, uniqueness: true

  def add_ingredient(ingredient)
    ingredients << ingredient
    save
  end
end
