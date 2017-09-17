class Article < ApplicationRecord
  self.table_name = 'articles'
  self.primary_key = 'id'

  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
end
