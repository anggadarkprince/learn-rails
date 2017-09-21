class Article < ApplicationRecord
  self.table_name = 'articles'
  self.primary_key = 'id'
  paginates_per 10

  enum status: [:published, :draft]

  belongs_to :user
  belongs_to :category

  has_many :comments, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  validates :title, presence: true, length: { minimum: 5 }
  validates :slug, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 5, maximum: 10000 }
  validates :views, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
