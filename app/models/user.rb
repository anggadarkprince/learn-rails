require 'bcrypt'
class User < ApplicationRecord
  # users.password_hash in the database is a :string
  include BCrypt

  attr_accessor :current_password
  attr_accessor :new_password
  attr_accessor :new_password_confirmation

  def verify_password
    @password ||= Password.new(password)
  end

  def hash_password=(new_password)
    @password = Password.create(new_password)
    self.password = @password
  end

  before_save :encrypt_password
  after_save :clear_password

  def encrypt_password
    if password.present?
      self.password = Password.create(password)
    end
  end

  def clear_password
    self.password = nil
  end

  enum role: [:writer, :editor, :admin]
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 50 }, format: {with: /\A[a-zA-Z1-9\-._]+\z/, message: 'Username allow alphanumeric, dash, dot and underscore only' }
  validates :email, presence: true, uniqueness: true, length: { maximum: 50 }, format: {with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i}
  validates :password, presence: true, confirmation: true, length: { in: 6..20 }, :on => :create
  validates :password_confirmation, presence: true, :on => :create
  validates :terms_of_service, acceptance: { message: 'You must accept out terms and service' }, :on => :create

  validate :must_include_current_password, on: :update
  validates :new_password, allow_blank: true, length: { in: 6..20 }, confirmation: true
  validates :new_password_confirmation, presence: true, on: :update, if: :is_change_password?
  validates :about, length: { minimum: 10, maximum: 300 }, allow_blank: true, on: :update

  def is_change_password?
    if self.new_password.empty?
      return false
    else
      self.password = new_password
      return true
    end
  end

  def must_include_current_password
    if verify_password != current_password
      errors.add(:current_password, 'Password mismatch with the current one.')
    else
      self.password = current_password
    end
  end

  has_many :articles, dependent: :destroy
end
