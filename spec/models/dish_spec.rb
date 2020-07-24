require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it { should have_many :dish_ingredients }
    it { should have_many(:ingredients).through(:dish_ingredients) }
  end
  describe "methods" do
    before :each do
      @chef_too_sweet = Chef.create!(name: "Too Sweet")

      @sugar_water = @chef_too_sweet.dishes.create!(name: "Sugar Water", description: "It's too sweet!")

      @water = Ingredient.create!(name: "Water", quantity: 1, units: "L", calories_per_unit: 0)
      @sugar = Ingredient.create!(name: "Sugar", quantity: 3, units: "cups", calories_per_unit: 700)

      @sugar_water.ingredients << [@sugar, @water]
    end

    it "#total_calories" do
      expect(@sugar_water.total_calories).to eq(2100)
    end
  end
end
