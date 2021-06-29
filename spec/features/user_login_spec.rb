require 'rails_helper'

RSpec.feature "UserLogin", type: :feature, js: true do
  before :each do
      User.create!(
        first_name: "Thom",
        last_name: "Yorke",
        email: "MrRadio@gmail.com",
        password: "123456",
        password_confirmation: "123456"
      )
  end
  scenario "User can login using their correct email and password" do
    # ACT
    visit root_path
    expect(page).to have_text 'Login'
    click_on "Login"

    # DEBUG / VERIFY
    fill_in 'email', with: 'MrRadio@gmail.com'
    fill_in 'password', with: '123456'
    click_on "Submit"
    expect(page).to have_text 'Signed in as MrRadio@gmail.com'
    save_screenshot
  end
  
  scenario "User is redirected to login when their email or password is incorrect" do
    # ACT
    visit root_path
    expect(page).to have_text 'Login'
    click_on "Login"

    # DEBUG / VERIFY
    fill_in 'email', with: 'MrRadio@gmail.com'
    fill_in 'password', with: '654321'
    click_on "Submit"
    expect(page).to_not have_text 'Signed in as MrRadio@gmail.com'
    save_screenshot
  end
end
