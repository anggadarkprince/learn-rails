class Article < ApplicationRecord
  self.table_name = 'articles'
  self.primary_key = 'id'
  paginates_per 10

  enum status: {published: 'published', draft: 'draft'}

  validates :title, presence: true, length: { maximum: 200 }
  validates :slug, presence: true, length: { maximum: 500 }
  validates :content, presence: true, length: { minimum: 5, maximum: 10000 }
  validates :views, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :user
  belongs_to :category, optional: true

  has_many :comments, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  def all_tags=(tags)
    self.tags = tags.split(',').map do |tag_name|
      Tag.where(slug: tag_name.strip.parameterize, tag: tag_name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:tag).join(', ')
  end
end
