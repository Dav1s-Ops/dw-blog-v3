require 'rails_helper'

RSpec.feature "Admin Posts Index", type: :feature do
  let!(:admin) { User.create(email: 'admin@example.com', password: 'password') }

  let!(:categories) {
    [ 'Frontend', 'Backend', 'Fullstack', 'DevOps', 'News', 'Personal' ].map do |category_name|
      Category.create(name: category_name)
    end
  }

  let!(:tags) {
    [ 'Beginner', 'Advanced', 'Tips', 'Best Practices', 'Performance' ].map do |tag_name|
      Tag.create(name: tag_name)
    end
  }

  let!(:posts) {
    Array.new(50) do |i|
      Post.create(
        title: "Sample Post #{i + 1}",
        content: "# Sample Post #{i + 1}\n",
        status: Post.statuses.keys.sample,
        user: admin,
        categories: categories.sample(rand(1..4)),
        tags: tags.sample(rand(1..5))
      )
    end
  }

  before do
    sign_in admin
  end

  context 'when rendering the index page' do
    before { visit admin_posts_path }

    it 'displays the correct title and "Add New Post" link' do
      expect(page).to have_content('Post Management')
      expect(page).to have_link('Add New Post', href: new_admin_post_path)
    end

    it 'displays a table with the list of posts' do
      expect(page).to have_selector('table.admin-posts__table')

      within 'table.admin-posts__table' do
        expect(page).to have_selector('th', text: 'ID')
        expect(page).to have_selector('th', text: 'Title')
        expect(page).to have_selector('th', text: 'Slug')
        expect(page).to have_selector('th', text: 'Status')
        expect(page).to have_selector('th', text: 'Actions')

        within 'tbody' do
          displayed_posts = Post.order(created_at: :desc).limit(10)
          displayed_posts.each do |post|
            expect(page).to have_selector('td', text: post.id.to_s)
            expect(page).to have_link(post.title, href: admin_post_path(post))
            expect(page).to have_selector('td', text: post.slug)
            expect(page).to have_selector('td', text: post.status.capitalize)
            expect(page).to have_link('Edit', href: edit_admin_post_path(post))
            expect(page).to have_selector("button[data-delete-url='#{admin_post_path(post)}'][data-post-title='#{post.title}']")
          end
        end
      end
    end

    it 'displays pagination controls' do
      expect(page).to have_selector('.admin-posts__pagination')
      within('.admin-posts__pagination') do
        expect(page).to have_link('>', href: '/admin/posts?page=2')
        expect(page).to have_link('2', href: '/admin/posts?page=2')
      end
    end
  end

  context 'when navigating through pagination' do
    it 'displays the correct posts on each page' do
      total_pages = (posts.count / 10.0).ceil

      (1..total_pages).each do |page_number|
        visit admin_posts_path(page: page_number)
        offset = (page_number - 1) * 10
        displayed_posts = Post.order(created_at: :desc).offset(offset).limit(10)

        within 'table.admin-posts__table tbody' do
          displayed_posts.each do |post|
            expect(page).to have_selector('td', text: post.id.to_s)
            expect(page).to have_link(post.title, href: admin_post_path(post))
            expect(page).to have_selector('td', text: post.slug)
            expect(page).to have_selector('td', text: post.status.capitalize)
          end
        end
      end
    end
  end

  context 'when deleting a post', js: true do
    it 'removes the post from the list upon confirmation', skip: "Add cuprite for JS testing in the future "  do
      post_to_delete = Post.order(created_at: :desc).first
      visit admin_posts_path

      delete_button = find("button[data-delete-url='#{admin_post_path(post_to_delete)}'][data-post-title='#{post_to_delete.title}']")
      delete_button.click

      expect(page).to have_selector('dialog.dialog[open]')

      within 'dialog.dialog' do
        expect(page).to have_content('Delete Post?')
        expect(page).to have_content(post_to_delete.title)
        click_button 'Delete'
      end

      expect(current_path).to eq(admin_posts_path)
      expect(page).to have_content('Post deleted.')
      expect(page).not_to have_content(post_to_delete.title)
    end
  end
end
