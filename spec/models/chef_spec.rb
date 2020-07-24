require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
  end
  describe "methods" do
    before :each do
      @chef_tofu = Chef.create!(name: "Tofu")

      @lemonade = @chef_tofu.dishes.create!(name: "Lemonade", description: "Freshly squeezed")
      @lemonade_water = Ingredient.create!(name: "Water", quantity: 1, units: "L", calories_per_unit: 0)
      @lemonade_sugar = Ingredient.create!(name: "Sugar", quantity: 5, units: "cups", calories_per_unit: 773)
      @lemonade_lemon_juice = Ingredient.create!(name: "Lemon Juice", quantity: 1, units: "L", calories_per_unit: 220)
      @lemonade.ingredients << [@lemonade_water, @lemonade_sugar, @lemonade_lemon_juice]

      @sugar_water = @chef_tofu.dishes.create!(name: "Sugar Water", description: "It's too sweet!")
      @water = Ingredient.create!(name: "Water", quantity: 1, units: "L", calories_per_unit: 0)
      @sugar = Ingredient.create!(name: "Sugar", quantity: 3, units: "cups", calories_per_unit: 700)
      @sugar_water.ingredients << [@sugar, @water]
    end

    it "#ingredients" do
      expect(@chef_tofu.ingredients).to eq(["Lemon Juice", "Sugar", "Water"])
    end
  end
end
