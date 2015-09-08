class AccountsController < ApplicationController

  respond_to :json

  def index
    respond_with Account.all
  end

  def show
    respond_with Account.find(params[:id])
  end

  def create
    respond_with Account.create(account_params)
  end

  def update
    respond_with Account.update(params[:id], account_params)
  end

  def destroy
    respond_with Account.destroy(params[:id])
  end

  private

    def account_params
      params.require(:account).permit(:number)
    end

end
