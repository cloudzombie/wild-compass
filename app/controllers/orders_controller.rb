class OrdersController < ApplicationController
  helper_method :sort_column, :sort_direction

  expose(:order, params: :order_params) { id_param.nil? ? Order.new : Order.find(id_param) }
  expose(:orders) { Order.order(sort_column + ' ' + sort_direction) }


  # Create new order.
  def create 
    self.order = Order.new(order_params)
    order.save
    respond_with(order)
  end

  # Update order column.
  def update 
    order.update(order_params)
    respond_with(order)
  end

  # Destroy order.
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

    # Set column to sort in order.
    def sort_column
      %w(id customer total_weight ordered_at shipped_at).include?(params[:sort]) ? params[:sort] : 'ordered_at'
    end

    # Set sort direction to ascending or descending.
    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
