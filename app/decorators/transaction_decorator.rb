class TransactionDecorator < ApplicationDecorator
  
  decorates :transaction

  delegate_all

  def actions
  end

end
