
class Loan < ApplicationRecord
  belongs_to :user
  enum state: { requested: 0, approved: 1, open: 2, closed: 3, rejected: 4 }

  after_update :update_interest, if: -> { open? }

  private

  def update_interest
    InterestCalculationJob.perform_later(id)
  end
end #class end


