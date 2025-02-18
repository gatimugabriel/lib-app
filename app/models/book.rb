class Book < ApplicationRecord
  has_many :loans, dependent: :destroy
  validates :title, :author, presence: true

  def currently_borrowed?
    loans.exists?(returned_on: nil)
  end
end
