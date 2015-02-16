class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @transactions = Transaction.all
    respond_with(@transactions)
  end

  def show
    respond_with(@transaction)
  end

  def new
    @transaction = Transaction.new
    respond_with(@transaction)
  end

  def edit
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.save
    respond_with(@transaction)
  end

  def update
    @transaction.update(transaction_params)
    respond_with(@transaction)
  end

  def destroy
    @transaction.destroy
    respond_with(@transaction)
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:event, :source_type, :source_id, :target_type, :target_id, :weight)
    end
end
