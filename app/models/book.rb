class Book < ApplicationRecord
  has_many :loans, dependent: :destroy
  validates :title, :author, :isbn, :description, presence: true
  validates :isbn, uniqueness: true
  validates :image_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }

  def currently_borrowed?
    loans.exists?(returned_on: nil)
  end
end
