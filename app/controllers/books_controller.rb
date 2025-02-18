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
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
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
    @book = Book.find(params[:id])

    puts "Book: #{@book.inspect}"
    puts "Params: #{params.inspect}"

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
      puts "Loan errors: #{loan.errors.full_messages}"
      redirect_to @book, alert: loan.errors.full_messages.to_sentence
    end
  end

  def return
    @book = Book.find(params[:id])

    # Debugging: Print book and loans
    puts "Book: #{@book.inspect}"
    puts "Loans: #{@book.loans.inspect}"

    loan = @book.loans.where(returned_on: nil).last

    if loan&.update(returned_on: Time.current)
      redirect_to @book, notice: "Book successfully returned!"
    else
      redirect_to @book, alert: "No active loan found"
    end
  end

  private

  def set_book
    @book = Book.find(params.require(:id))
  end

  # Only allow a list of trusted parameters through.
  def book_params2
    params.expect(book: [:title, :author, :description])
  end

  def book_params
    params.require(:book).permit(:title, :author, :description)
  end
end
