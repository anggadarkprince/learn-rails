class Contact < ApplicationRecord
  validates :name, presence: true, length: { minimum: 5 }
  validates :email, presence: true, format: {with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i}
  validates :subject, presence: true
  validates :message, presence: true
end
