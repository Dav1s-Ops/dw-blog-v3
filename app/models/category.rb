class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_and_belongs_to_many :posts
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
