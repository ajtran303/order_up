require "rails_helper"

RSpec.describe "Dishes Show Page Spec" do
  describe "As a visitor" do
    describe "When I visit a dish's show page" do
      before :each do
        @chef_tofu = Chef.create!(name: "Tofu")

        @lemonade = @chef_tofu.dishes.create!(name: "Lemonade", description: "Freshly squeezed")

        @water = Ingredient.create!(name: "Water", quantity: 1, units: "L", calories_per_unit: 0)
        @sugar = Ingredient.create!(name: "Sugar", quantity: 5, units: "cups", calories_per_unit: 773)
        @lemon_juice = Ingredient.create!(name: "Lemon Juice", quantity: 1, units: "L", calories_per_unit: 220)

        @lemonade_ingredients = [@water, @sugar, @lemon_juice]

        @lemonade.ingredients << @lemonade_ingredients

        visit dish_path(@lemonade)
      end

      it "There is a list of ingredients for that dish" do
        within(".#{@lemonade.name.downcase}-ingredients") do
          expect(page).to have_content("#{@lemonade.name} Ingredients:")
          expect(page).to have_content("#{@water.name}")
          expect(page).to have_content("#{@sugar.name}")
          expect(page).to have_content("#{@lemon_juice.name}")
        end
      end

      it "There is the chef's name" do
        expect(page).to have_content("#{@lemonade.name}, by Chef #{@chef_tofu.name}")
      end
    end
  end
end
