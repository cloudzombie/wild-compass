class Account::TransactionsController < ApplicationController

  respond_to :json

  def index
    respond_with Account::Transaction.all
  end

  def show
    respond_with Account::Transaction.find(params[:id])
  end

  def create
    respond_with Account::Transaction.create(transaction_params)
  end

  def update
    respond_with Account::Transaction.update(params[:id], transaction_params)
  end

  def destroy
    respond_with Account::Transaction.destroy(params[:id])
  end

  private

    def transaction_params
      params.require(:transaction).permit(:credit, :debit, :value)
    end

end
