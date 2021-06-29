require 'rails_helper'

RSpec.feature "AddToCart", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    5.times do |n|
      @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
      )
    end
  end
  scenario "User can click the 'Add' button on a product to add item to their cart" do
    # ACT
    visit root_path
    expect(page).to have_text 'My Cart (0)'
    within(page.all('article.product').first) do
      click_on 'Add'
    end
    # DEBUG / VERIFY
    expect(page).to have_text 'My Cart (1)'
    save_screenshot
  end
end
