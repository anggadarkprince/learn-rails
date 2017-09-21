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
end
