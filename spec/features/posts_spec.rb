require 'rails_helper'

RSpec.feature "PublishedPosts", type: :feature do
  let(:user) { User.create(email: "test@test.com", password: "password") }
  let(:category) { Category.create(name: 'Test') }
  let(:tag) { Tag.create(name: 'Test') }

  before do
    @post = Post.create(title: 'Public Post', content: 'Content', status: :published, categories: [ category ], tags: [ tag ], user: user)
  end

  scenario "Visit the posts index" do
    visit posts_path

    expect(page).to have_content(@post.title)
    expect(page).to have_link('Read More', href: post_path(@post))
  end

  scenario "Visit the post show" do
    visit post_path(@post)

    expect(page).to have_content('Public Post')
    expect(page).to have_content('Content')
  end
end
