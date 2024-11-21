require "rails_helper"

RSpec.feature "Navbar", type: :feature do
  let!(:user) { User.create(email: 'user@example.com', password: 'password') }

  context "when a User clicks the Logo" do
    before do
      sign_in user
      visit admin_dashboard_path
    end
    it "it navigates to the home page" do
      find("img.logo-image").ancestor('a').click

      expect(current_path).to eq('/posts')
    end
  end

  context "when a User is signed in" do
    before do
      sign_in user
      visit root_path
    end

    it "it displays the dropdown menu and navigates to the correct pages" do
      expect(page).to have_selector('#navbar_menu_button', text: 'Menu')

      find('#navbar_menu_button').click

      within '.dropdown-menu' do
        expect(page).to have_link('Home', href: root_path)
        expect(page).to have_link('Dashboard', href: admin_dashboard_path)
        expect(page).to have_button('Logout')

        click_link 'Dashboard'
        expect(current_path).to eq(admin_dashboard_path)
      end

      visit root_path
      find('#navbar_menu_button').click
      within '.dropdown-menu' do
        click_button 'Logout'
      end
    end

    it "a User is signed out when Logout is clicked" do
      find('#navbar_menu_button').click
      find('button.dropdown-link-button', text: 'Logout').click

      find('#navbar_menu_button').click

      within '.dropdown-menu' do
        expect(page).to have_link('Home', href: root_path)
        expect(page).to have_link('Login')

        click_link 'Login'
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  context "when a User is signed out" do
    it "the only paths available are Home & Login" do
      visit root_path

      find('#navbar_menu_button').click

      within '.dropdown-menu' do
        expect(page).to have_link('Home', href: root_path)
        expect(page).to have_link('Login')
      end
    end
  end
end
