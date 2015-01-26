class API::V1::OrdersController < API::V1::APIController
  respond_to :json

  def index
    respond_with Order.all
  end

  def show
    respond_with Order.find(id_param)
  end

  def create
    respond_with Order.create!(order_params)
  end

  def update
    respond_with Order.update(order_params)
  end

  def destroy
    respond_with Order.destroy(id_param)
  end

  def datamatrix
    send_data Order.find(id_param).datamatrix, type: 'image/png', disposition: 'attachment'
  end

  def add_line
    respond_with order.order_lines << OrderLine.create(order_line_params)
  end

  private

    def order_line_params
      params.require(:order_line).permit(:brand_id, :quantity, :jar_id)
    end
    
    def order_params
      params.require(:order).permit(:customer, :shipped_at, :ordered_at,
      { order_lines_attributes: [ :id, :brand_id, :product_type, :product_id, :quantity ] })
    end

    def id_param
      params[:id]
    end

end