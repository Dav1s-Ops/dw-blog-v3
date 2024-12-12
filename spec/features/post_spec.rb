require 'rails_helper'

RSpec.feature "PostRendering", type: :feature do
  let(:user) { User.create(email: "test@test.com", password: "password") }
  let(:category) { Category.create(name: 'Backend') }
  let(:tags) { [Tag.create(name: 'Ruby'), Tag.create(name: 'Markdown')] }

  before do
    content = <<~MD
      # Ruby: The Elegant Programming Language

      Ruby is a dynamic, open-source programming language with a focus on simplicity and productivity.

      ## Why Choose Ruby?

      > **Ruby is optimized for developer happiness.**

      ### Key Features of Ruby
      - Elegant Syntax
      - Object-Oriented
      - Vibrant Ecosystem

      ```ruby
      puts "Hello, Ruby!"
      ```
    MD
    @post = Post.create!(
      title: 'Sample Post',
      content: content,
      status: :published,
      categories: [ category ],
      tags: tags,
      user: user
    )
  end

  scenario "Render post content as HTML" do
    visit post_path(@post)

    expect(page).to have_css('h1', text: 'Ruby: The Elegant Programming Language')
    expect(page).to have_css('h2', text: 'Why Choose Ruby?')
    expect(page).to have_css('blockquote', text: 'Ruby is optimized for developer happiness.')
    expect(page).to have_css('ul > li', text: 'Elegant Syntax')
    expect(page).to have_css('code', text: 'puts "Hello, Ruby!"')

    expect(page).to have_link('Backend', href: category_posts_path(category: category.slug))
    expect(page).to have_css('.post-tag', text: '#Ruby')
    expect(page).to have_css('.post-tag', text: '#Markdown')
  end

  scenario "Render code blocks with syntax highlighting" do
    visit post_path(@post)

    expect(page).to have_css('.code-block-wrapper .highlight code', text: 'puts "Hello, Ruby!"')
  end
end
