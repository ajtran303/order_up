require "rails_helper"

RSpec.describe "Chef Show Page Spec" do
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

    visit chef_path(@chef_tofu)
  end

  describe "As a visitor" do
    describe "When I visit a chef's show page" do
      it "There is the name of that chef and a link to their ingredients" do
        expect(page).to have_content("Chef Profile: #{@chef_tofu.name}")
        expect(page).to have_link("Learn more about their ingredients", href: chef_ingredients_path(@chef_tofu))
      end
      it "The link to their ingredients takes me to the chef's ingredient index page" do
        click_link "Learn more about their ingredients"

        expect(current_path).to eq(chef_ingredients_path(@chef_tofu))
        expect(page).to have_content("Ingredients used by #{@chef_tofu.name}")
        expect(page).to have_content("Lemon Juice")
        expect(page).to have_content("Sugar")
        expect(page).to have_content("Water")
      end
    end
  end
end
