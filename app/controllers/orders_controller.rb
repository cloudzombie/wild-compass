class OrdersController < ApplicationController
  helper_method :sort_column, :sort_direction

  expose(:order, params: :order_params) { id_param.nil? ? Order.new : Order.find(id_param) }
  expose(:orders) { Order.order(sort_column + ' ' + sort_direction) }

  def create #Create new order.
    self.order = Order.new(order_params)
    order.save
    respond_with(order)
  end

  def update #Update order column.
    order.update(order_params)
    respond_with(order)
  end

  def destroy #Destroy order.
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

    def sort_column
      %w(id customer total_weight ordered_at shipped_at).include?(params[:sort]) ? params[:sort] : 'ordered_at'
    end

    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
