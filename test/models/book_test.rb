require "test_helper"

=begin
 Tests covered here:

 1. Book should not be saved without title
 2. Book should not be saved without author
 3. Book should not be saved without isbn
 4. Book should not be saved with duplicate isbn
 5. Book should not be saved with invalid image url
 6. Book should be marked as borrowed
=end

class BookTest < ActiveSupport::TestCase
  test "should not save book without title" do
    book = Book.new(author: "Robert Greene", isbn: "563256781", description: "Some book Description", image_url: "https://example.com/image.jpg")
    assert_not book.save, "Saved book without title"
  end

  test "should not save book without author" do
    book = Book.new(title: "War", isbn: "563256781", description: "Some book Description", image_url: "https://example.com/image.jpg")
    assert_not book.save, "Saved book without author"
  end

  test "should not save book without isbn" do
    book = Book.new(title: "War", author: "Robert Greene", description: "Some book Description", image_url: "https://example.com/image.jpg")
    assert_not book.save, "Saved book without isbn"
  end

  test "should not save book with duplicate isbn" do
    Book.create(title: "War", author: "Robert Greene", isbn: "563256781", description: "Some book Description", image_url: "https://example.com/image.jpg")
    book = Book.new(title: "War", author: "Robert Greene", isbn: "563256781", description: "Some book Description", image_url: "https://example.com/image.jpg")
    assert_not book.save, "Saved book with duplicate isbn"
  end

  test "should not save book with invalid image url" do
    book = Book.new(title: "War", author: "Robert Greene", isbn: "563256781", description: "Some book Description", image_url: "invalid_url")
    assert_not book.save, "Saved book with invalid image url"
  end

  test "should mark book as borrowed" do
    book = Book.create(title: "War", author: "Robert Greene", isbn: "563256781", description: "Some book Description", image_url: "https://example.com/image.jpg")
    assert_not book.currently_borrowed?, "Book should not be borrowed initially"

    book.loans.create(borrower_name: "Gabriel", borrowed_on: Time.now, due_date: 14.days.from_now)
    assert book.currently_borrowed?, "Book should be marked as borrowed"
  end
end
