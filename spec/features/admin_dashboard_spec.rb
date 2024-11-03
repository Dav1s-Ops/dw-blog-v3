require 'rails_helper'

RSpec.feature "Admin::Dashboard", type: :feature do
  let(:user) { User.create(email: 'admin@example.com', password: 'password') }

  before do
    sign_in user
  end

  scenario "User sees dashboard stats" do
    visit admin_dashboard_path

    expect(page).to have_content("Total Posts")
    expect(page).to have_content("Draft Posts")
    expect(page).to have_content("Total Categories")
    expect(page).to have_content("Total Tags")

    expect(page).to have_selector('#chart-posts-by-category')
    expect(page).to have_selector('#chart-top-5-tags')
  end
end