class Account::PrefixesController < ApplicationController

  respond_to :json

  def index
    respond_with Account::Prefix.all
  end

  def show
    respond_with Account::Prefix.find(params[:id])
  end

  def create
    respond_with Account::Prefix.create(prefix_params)
  end

  def update
    respond_with Account::Prefix.update(params[:id], prefix_params)
  end

  def destroy
    respond_with Account::Prefix.destroy(params[:id])
  end

  private

    def prefix_params
      params.require(:prefix).permit(:name)
    end

end
