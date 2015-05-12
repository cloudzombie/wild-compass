class API::V1::OrdersController < API::V1::APIController
  respond_to :json

  def index
    respond_with Order.all
  end

  def show
    order = Order.find(id_param)
    respond_with order do |format|
      format.json { render json: order, include: [ order_lines: { include: [ jars: { include: [ :lot ] } ] } ] }
    end
  end

  def create
    order = Order.create_with(order_params).find_or_create_by!(ces_order_id: order_params[:ces_order_id])

    respond_with order do |format|
      format.json { render json: order, include: [ order_lines: { include: [ jars: { include: [ :lot ] } ] } ] }
    end
  end

  def update
    order = Order.update(order_params)
    respond_with order do |format|
      format.json { render json: order, include: [ order_lines: { include: [ jars: { include: [ :lot ] } ] } ] }
    end
  end

  def destroy
    respond_with Order.destroy(id_param)
  end

  private
    
    def order_params
      params.require(:order).permit(:customer, :shipped_at, :ordered_at, :ces_order_id, :created_by, :placed_by,
      { order_lines_attributes: [ :id, :brand_id, :product_type, :product_id, :quantity ] })
    end

    def id_param
      params[:id]
    end

end