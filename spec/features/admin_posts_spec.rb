require 'rails_helper'

RSpec.feature "Admin Posts", type: :feature do
  let!(:admin) { User.create(email: 'admin@example.com', password: 'password') }

  let!(:categories) do
    [
      Category.create(name: 'Frontend'),
      Category.create(name: 'Backend'),
      Category.create(name: 'Fullstack')
    ]
  end

  let!(:tags) do
    [
      Tag.create(name: 'Frontend'),
      Tag.create(name: 'Backend'),
      Tag.create(name: 'Fullstack')
    ]
  end

  before do
    sign_in admin
    visit new_admin_post_path
  end

  context 'when rendering the new post form' do
    it 'displays the form elements correctly' do
      expect(page).to have_selector('form.add-post-form__container')

      within '.add-post-form__content' do
        expect(page).to have_selector('textarea.add-post-form__content-input')
      end

      within '.add-post-form__attributes' do
        expect(page).to have_selector('input.add-post-form__input', count: 1)
        expect(page).to have_selector('textarea.add-post-form__input.add-post-form__textarea')
        expect(page).to have_selector('select.add-post-form__input')
      end

      within '.add-post-form__checkbox-group' do
        categories.each do |category|
          expect(page).to have_field("category_#{category.id}", type: 'checkbox', checked: false)
          expect(page).to have_field("post[category_ids][]", type: 'checkbox', with: category.id.to_s)
        end
      end

      within '.add-post-form__buttons' do
        expect(page).to have_button('Save Post')
      end
    end
  end

  context 'when submitting a valid post' do
    it 'creates a new post' do
      within 'form.add-post-form__container' do
        fill_in 'Title', with: 'Test Post Title'
        fill_in 'Tags', with: 'Tag1, Tag2, Tag3'
        fill_in 'post_content', with: 'This is the content of the test post.'
        select 'Published', from: 'Status'
        categories.each do |category|
          check category.name
        end

        click_button 'Save Post'
      end

      visit root_path
      expect(page).to have_content('Test Post Title')
    end
  end

  context 'when rendering the edit post form' do
    it 'pre-fills the form with post data' do
      @existing_post = Post.create(title: 'Existing Post', content: 'This is a unique post.', categories: categories, tags: tags, user: admin)
      visit edit_admin_post_path(@existing_post)

      expect(page).to have_field('Title', with: 'Existing Post')
      expect(page).to have_field('Tags', with: @existing_post.tag_list)
      categories.each do |category|
        expect(page).to have_checked_field("category_#{category.id}") if @existing_post.categories.include?(category)
      end
    end

    it 'updates the post' do
      @existing_post = Post.create(title: 'Existing Post', content: 'This is a unique post.', categories: categories, tags: tags, user: admin)
      visit edit_admin_post_path(@existing_post)

      within 'form.add-post-form__container' do
        fill_in 'Title', with: 'Updated Post Title'
        uncheck categories.first.name
        select 'Published', from: 'Status'

        click_button 'Update Post'
      end

      visit root_path
      expect(page).to have_content('Updated Post Title')
    end
  end
end
