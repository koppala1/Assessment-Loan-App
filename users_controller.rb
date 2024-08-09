class UsersController < ApplicationController
  before_action :authenticate_user!

  def request_loan
    loan = current_user.loans.create(loan_params.merge(state: 'requested'))
  end

  def confirm_loan
    loan = Loan.find(params[:id])
    loan.update(state: 'open')
  end

  def repay_loan
    loan = current_user.loans.find(params[:id])
    if current_user.wallet >= loan.amount
      RepaymentJob.perform_later(current_user.id)
    #else
     # render :show
    end
  end
  
  def show
  end 

  private

  def loan_params
    params.require(:loan).permit(:amount, :interest_rate)
  end

end #class end
