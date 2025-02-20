class BookMailer < ApplicationMailer
  default from: "geraldg652@gmail.com"
  def notify_availability(email, book)
    @book = book
    mail(to: email, subject: "#{book.title} is now available")
  end
end
