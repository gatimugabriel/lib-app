class Book < ApplicationRecord
  has_many :loans, dependent: :destroy
  has_many :subscribers, dependent: :destroy
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
      BookMailer.notify_availability(subscriber.email, self).deliver_now
    end
    subscribers.destroy_all
  end
end
