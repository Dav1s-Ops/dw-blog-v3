require "csv"

class Post < ApplicationRecord
  belongs_to :user

  enum status: [ :draft, :published ]

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :tags

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :content, presence: true
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validate :must_have_at_least_one_category
  validate :must_have_at_least_one_tag

  def tag_list
    @tag_list || tags.pluck(:name).join(", ")
  end

  def tag_list=(names)
    @tag_list = names
    process_tags
  end

  private

  def process_tags
    return if @tag_list.blank?

    tag_names = CSV.parse_line(@tag_list, col_sep: ",").map(&:strip).reject(&:blank?)
    self.tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }
  end

  def must_have_at_least_one_category
    errors.add(:categories, "must have at least one category") if categories.empty?
  end

  def must_have_at_least_one_tag
    if @tag_list.blank? && tags.empty?
      errors.add(:tags, "must have at least one tag")
    end
  end
end
