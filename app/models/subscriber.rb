class Subscriber < ApplicationRecord
  belongs_to :book
  validates :email, presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP,   message: "must be a valid email address" }
  validates :email, uniqueness: { scope: :book_id, message: "is already subscribed to this book" }
end
