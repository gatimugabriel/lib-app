class CreateLoans < ActiveRecord::Migration[8.0]
  def change
    create_table :loans do |t|
      t.references :book, null: false, foreign_key: true
      t.string :borrower_name
      t.datetime :borrowed_on
      t.datetime :returned_on

      t.timestamps
    end
  end
end
