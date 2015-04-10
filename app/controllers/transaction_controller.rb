class TransactionController < ApplicationController
  include Authorizable

  expose(:checkouts) { Checkout.all }
  expose(:checkout, params: :checkout_params) { params[:id].nil? ? Checkout.new : Checkout.find(params[:id]) }

  def checkin
  end

  def checkout
  end

  private

    def checkout_params
      params.require(:checkout).permit(:id, :target_id, :target_type, :user_id)
    end
    
end
