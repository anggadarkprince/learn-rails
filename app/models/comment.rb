class Comment < ApplicationRecord
  belongs_to :article
  has_many :comments, dependent: :destroy
end
