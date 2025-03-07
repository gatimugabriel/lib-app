# frozen_string_literal: true

class LoansController < ApplicationController
  def index
    @loans = Loan.all.order(borrowed_on: :desc)
  end

  def borrower_history
    @borrower_name = params[:borrower_name]
    @loans = Loan.where(borrower_name: @borrower_name).order(borrowed_on: :desc)

    if @loans.empty?
      flash[:alert] = "No loans found for borrower '#{@borrower_name}'"
      redirect_to loans_path
    end
  end
end
