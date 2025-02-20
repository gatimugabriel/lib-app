class Loan < ApplicationRecord
  belongs_to :book
  validates :borrower_name, presence: true

  validate :return_date_validity
  validate :due_date_validity

  private

  def return_date_validity
    return if returned_on.blank?

    if returned_on <= borrowed_on
      errors.add(:returned_on, "must be after borrowed date")
    end
  end

  def due_date_validity
    return if due_date.blank?
    errors.add(:due_date, "must be after borrow date") if due_date <= borrowed_on
  end
end
