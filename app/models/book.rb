class Book < ApplicationRecord
  has_many :loans, dependent: :destroy
  validates :title, :author, presence: true
end
