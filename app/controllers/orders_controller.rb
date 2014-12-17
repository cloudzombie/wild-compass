class OrdersController < ApplicationController
  expose(:order, params: :order_params) { id_param.nil? ? Order.new : Order.find(id_param) }
  expose(:orders) { Order.all }

  def create
    self.order = Order.new(order_params)
    order.save
    respond_with(order)
  end

  def update
    order.update(order_params)
    respond_with(order)
  end

  def destroy
    order.destroy
    respond_with(order)
  end

  private
    def id_param
      params[:id]
    end

    def order_params
      params.require(:order).permit(:customer, :order_lines)
    end
end
