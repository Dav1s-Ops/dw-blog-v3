require 'rails_helper'

RSpec.feature "User Authentication", type: :feature do
  let(:user) { User.create(email: "test@test.com", password: "password") }

  scenario "User logs in successfully" do
    visit new_user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(current_path).to eq(admin_dashboard_path)
  end

  scenario "User logs out successfully" do
    sign_in user
    visit admin_dashboard_path
    click_button 'Logout'

    expect(current_path).to eq("/posts")
  end
end
