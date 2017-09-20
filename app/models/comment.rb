class Comment < ApplicationRecord
  belongs_to :article
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5 }
  validates :email, presence: true
  validates :comment, presence: true
end
