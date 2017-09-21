class User < ApplicationRecord
  enum role: [:writer, :editor, :admin]
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 50 }, format: {with: /\A[a-zA-Z1-9\-._]+\z/, message: 'Username allow alphanumeric, dash, dot and underscore only' }
  validates :email, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :password, presence: true, confirmation: true, length: { minimum: 5, maximum: 50 }
  validates :password_confirmation, presence: true
  validates :terms_of_service, acceptance: { message: 'You must accept out terms and service' }
  validates :about, length: { minimum: 10, maximum: 300 }, allow_blank: true, on: :update

  has_many :articles, dependent: :destroy
end
