class Post < ApplicationRecord
  belongs_to :user

  enum status: [ :draft, :published ]

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :tags

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :content, presence: true
  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
