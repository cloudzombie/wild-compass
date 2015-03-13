class TransactionsController < ApplicationController
  
  expose(:transaction, attributes: :transaction_params) { params[:id].nil? ? Transaction.new : Transaction.find(params[:id]) }
  expose(:transactions) { Transaction.all }

  respond_to :html

  def create
    self.transaction = Transaction.new(transaction_params)
    transaction.save
    respond_with(transaction)
  end

  def update
    transaction.update(transaction_params)
    respond_with(transaction)
  end

  def destroy
    transaction.destroy
    respond_with(transaction)
  end

  private

    def transaction_params
      params.require(:transaction).permit(:event, :source_type, :source_id, :target_type, :target_id, :weight)
    end
    
end
