class TransactionDecorator < ApplicationDecorator
  
  decorates :transaction

  delegate_all

end
