class Book < ApplicationRecord
  has_many :loans, dependent: :destroy
  has_many :subscribers, dependent: :destroy
  validates :title, :author, :isbn, :description, presence: true
  validates :isbn, uniqueness: true
  validates :image_url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }, allow_blank: true

  def currently_borrowed?
    # loans.exists?(returned_on: nil)
    loans.any? { |loan| loan.returned_on.nil? }
  end

  def upload_image(file)
    return if file.blank?
    # if Cloudinary credentials are available, upload image to cloud, else use default placeholder
    if cloudinary_configured?
      response = Cloudinary::Uploader.upload(file, public_id: "books/#{isbn}")
      self.image_url = response["secure_url"]
    else
      self.image_url = default_image_url
    end
  end

  def cloudinary_configured?
    ENV["CLOUDINARY_CLOUD_NAME"].present? &&
    ENV["CLOUDINARY_API_KEY"].present? &&
    ENV["CLOUDINARY_API_SECRET"].present?
  end

  def default_image_url
    "https://placehold.co/150/4f39f6/@3x.png?font=oswald&text=img"
  end

  def image_url_or_placeholder
    image_url.presence || default_image_url
  end

  def notify_subscribers
    subscribers.each do |subscriber|
      BookMailer.notify_availability(subscriber.email, self).deliver_now
    end
    subscribers.destroy_all
  end
end
