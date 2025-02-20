class Book < ApplicationRecord
  has_many :loans, dependent: :destroy
  validates :title, :author, :isbn, :description, presence: true
  validates :isbn, uniqueness: true
  validates :image_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }

  def currently_borrowed?
    # loans.exists?(returned_on: nil)
    loans.any? { |loan| loan.returned_on.nil? }
  end

  def upload_image(file)
    return if file.blank?
    # upload to cloudinary
    response = Cloudinary::Uploader.upload(file, public_id: "books/#{isbn}")
    self.image_url = response["secure_url"]
  end

  def notify_subscribers
    subscribers.each do |subscriber|
      BookMailer.with(user: subscriber, book: self).new_book_email.deliver_later
    end
  end
end
