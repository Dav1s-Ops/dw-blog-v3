require 'rails_helper'

RSpec.feature "User Authentication", type: :feature do
  let(:user) { User.create(email: "test@test.com", password: "password" ) }

  scenario "User logs in successfully" do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Logout')
    expect(current_path).to eq(admin_dashboard_path)
  end
end