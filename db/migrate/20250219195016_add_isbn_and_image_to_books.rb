class AddIsbnAndImageToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :isbn, :string
    add_index :books, :isbn, unique: true
    add_column :books, :image_url, :string
  end
end
