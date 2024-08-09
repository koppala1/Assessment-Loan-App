class RepaymentJob < ApplicationJob
  queue_as :default

  #method implementation
  def perform(user_id)
    user = User.find(user_id)
    user.loans.open.each do |loan|
      if user.wallet >= loan.amount
        user.update(wallet: user.wallet - loan.amount)
        Admin.first.update(wallet: Admin.first.wallet + loan.amount)
        loan.update(state: :closed)
      else
        Admin.first.update(wallet: Admin.first.wallet + user.wallet)
        user.update(wallet: 0)
        loan.update(state: :closed)
      end
    end
  end
end

