class Loan < ApplicationRecord
  belongs_to :book
  validates :borrower_name, presence: true

  validate :return_date_validity

  private
  def return_date_validity
    return if returned_on.blank? # Skip validation if returned_on is nil

    if returned_on <= borrowed_on
      errors.add(:returned_on, "must be after borrowed date")
    end
  end
end
