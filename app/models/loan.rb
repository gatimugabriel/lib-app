class Loan < ApplicationRecord
  belongs_to :book
  validates :borrower_name, presence:  true
  validates :return_date_validity, presence: true

  private
  # Validation check to ensure return date is always in future
  def return_date_validity
    return if returned_on.blank?
    errors.add(:returned_on, "must be after borrowed date") if returned_on <= borrowed_on
  end
end



