class AddDueDateToLoan < ActiveRecord::Migration[8.0]
  def change
    add_column :loans, :due_date, :datetime
  end
end
