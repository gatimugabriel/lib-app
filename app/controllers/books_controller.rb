class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  def index
    @books = Book.all
  end

  # GET /books/1 or /books/1.json
  def show
    @loans = @book.loans.order(borrowed_on: :desc)
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to books_path, notice: "Book was successfully created." } # Redirect to books index
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @book.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @book.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_path, status: :see_other, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Book LOANs
  def borrow
    @book = set_book

    # Prevent borrowing if book is already borrowed
    if @book.currently_borrowed?
      redirect_to @book, alert: "Book is already borrowed!"
      return
    end

    loan = @book.loans.build(
      borrower_name: params[:borrower_name],
      borrowed_on: Time.current
    )

    if loan.save
      redirect_to @book, notice: "Book borrowed successfully!"
    else
      puts "Borrowing errors: #{loan.errors.full_messages}"
      redirect_to @book, alert: loan.errors.full_messages.to_sentence
    end
  end

  def return
    @book = set_book

    if params[:returner_name].blank?
      @loan = @book.loans.where(returned_on: nil).last
      render :return
      return
    end

    loan = @book.loans.where(returned_on: nil).last

    if loan.nil?
      redirect_to @book, alert: "This book is not currently borrowed!"
      return
    end

    # Verify returner name matches borrower name
    if params[:returner_name].downcase != loan.borrower_name.downcase
      redirect_to return_book_path(@book), alert: "The returner's name must match the borrower's name!"
      return
    end

    loan.returned_on = Time.current

    # Calculate penalty if book is overdue
    # days_overdue = (Time.current.to_date - loan.due_date.to_date).to_i
    days_overdue = 4
    if days_overdue > 0
      penalty_amount = (days_overdue * 0.50).round(2)
      # SIMULATED: the penalty is added to user's financial account
      notice = "Book has been successfully returned! A penalty of $#{penalty_amount} has been added to your(#{loan.borrower_name}) account."
    else
      notice = "Book has been successfully returned!"
    end

    if loan.save
      redirect_to books_path, notice: notice
    else
      redirect_to return_book_path(@book), alert: loan.errors.full_messages.to_sentence
    end
  end


  private

  def set_book
    @book = Book.find(params.expect(:id))
  end

  # trusted parameters
  def book_params
    params.expect(book: [ :title, :author, :description ])
  end
end
