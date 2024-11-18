require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(email: 'user@example.com', password: 'password') }
  let(:category) { Category.create(name: 'Test') }
  let(:tag) { Tag.create(name: 'Test') }

  before do
    Post.create(title: 'Unique Post Title', content: 'This is a unique post.', categories: [category], tags: [tag], user: user)
  end

  it { should belong_to(:user) }
  it { should have_and_belong_to_many(:categories) }
  it { should have_and_belong_to_many(:tags) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_uniqueness_of(:title).case_insensitive }

  it { should define_enum_for(:status).with_values(draft: 0, published: 1) }

  it 'generates a slug before saving' do
    post = Post.create(title: 'Sample Post', content: 'This is a post.', user: user)
    expect(post.slug).to eq('sample-post')
  end
end
