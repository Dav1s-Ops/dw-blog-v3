require 'rails_helper'

RSpec.feature "PublishedPosts", type: :feature do
  let(:user) { User.create(email: "test@test.com", password: "password") }
  let(:category) { Category.create(name: 'Test') }
  let(:tag) { Tag.create(name: 'Test') }

  before do
    @post = Post.create!(title: 'Public Post', content: 'Content', status: :published, categories: [ category ], tags: [ tag ], user: user)
    10.times do |i|
      Post.create!(title: "Another Public Post #{i + 1}", content: 'Other Content', status: :published, categories: [ category ], tags: [ tag ], user: user)
    end
  end

  scenario "Visit the posts index and view welcome section" do
    visit posts_path

    expect(page).to have_css('h1.welcome-title', text: 'Welcome!')
    expect(page).to have_css('p.welcome-text', text: "I'm Davis, a SWE exploring the universe of software")
    expect(page).to have_link(nil, href: 'https://www.dw-portfolio.com/')
    expect(page).to have_link(nil, href: 'https://github.com/Dav1s-Ops')
    expect(page).to have_link(nil, href: 'https://www.linkedin.com/in/davis-weimer')
  end

  scenario "Visit the posts index and view posts" do
    visit posts_path

    expect(page).to have_content(@post.title)
    10.times do |i|
      expect(page).to have_content("Another Public Post #{i + 1}")
    end

    expect(page).to have_button('Load more')
  end

  scenario "Clicking the 'Load more' button (skipped for now)", skip: "Add cuprite for JS testing in the future" do
    visit posts_path

    find('button.load-more').click

    expect(page).to have_content("Another Public Post 11")
  end

  scenario "Filter posts by category (skipped for now)", skip: "Add cuprite for JS testing in the future" do
    visit posts_path

    find('a', text: 'Test').click

    expect(page).to have_content(@post.title)
    expect(page).to have_no_content('Another Public Post')
  end

  scenario "Visit the post show page" do
    visit post_path(@post)

    expect(page).to have_content('Public Post')
    expect(page).to have_content('Content')
  end
end
