class InterestCalculationJob < ApplicationJob
  queue_as :default

  def perform(loan_id)
    loan = Loan.find(loan_id)
    return unless loan.open?

    interest = (loan.amount * loan.interest_rate / 100.0)
    loan.update(amount: loan.amount + interest)
  end
end 

