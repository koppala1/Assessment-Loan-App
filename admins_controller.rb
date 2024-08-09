class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def approve_loan
    loan = Loan.find(params[:id])
    loan.update(state: 'approved', interest_rate: params[:interest_rate])
  end

  def reject_loan
    loan = Loan.find(params[:id])
    loan.update(state: 'rejected')
  end

end #class End

