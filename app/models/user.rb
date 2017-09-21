class User < ApplicationRecord
  enum role: [:writer, :editor, :admin]

  has_many :articles, dependent: :destroy
end
