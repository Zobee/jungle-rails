require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do
    @main_category = Category.create! name: 'Apparel'
    @unrelated_category = Category.create! name: 'Home'

    5.times do |n|
      @main_category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
      )
    end

    5.times do |n|
      @unrelated_category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
      )
    end
  end
  scenario "User can navigate from the home page to the product detail page by clicking on a product" do
    # ACT
    visit root_path
    expect(page).to have_css 'article.product-detail', count: 0
    within(page.all('footer.actions').first) do
      click_on 'Details'
    end
    # DEBUG / VERIFY
    expect(page).to have_css 'article.product-detail', count: 1
    save_screenshot
    puts page.html
  end
end
