class OrdersController < ApplicationController

  include Authorizable
  include SetSortable

  # Expose order and orders for views 
  # If no id is specified, a new order is instanciated (not created)
  expose(:order, params: :order_params) { params[:id].nil? ? Order.new.decorate : Order.find(params[:id]).decorate }
  expose(:orders) { Order.search(params[:search]).unfulfilled.sort(sort_column, sort_direction).decorate }

  expose(:jar) { Jar.new }

  expose(:jars) { action_name == 'index' ? Jar.unfulfilled : order.jars }
  expose(:bags) { action_name == 'index' ? Bag.unfulfilled : order.bags }
  expose(:bins) { action_name == 'index' ? Bin.unfulfilled : order.bins }

  expose(:brands) { Brand.all }

  respond_to :html, :xml, :json

  def new
    order.order_lines.build
  end

  def show
    respond_with(order) do |format|
      format.html
      format.json { render json: order, include: [ order_lines: { include: [ jars: { include: [ :lot ] } ] } ] }
    end
  end

  def create
    self.order = Order.new(order_params)
    order.save
    respond_with(order) do |format|
      format.html { redirect_to order, notice: 'Order successfully created.' }
      format.json { render json: order, include: [ order_lines: { include: [ jars: { include: [ :lot ] } ] } ] }
    end
  end

  def update 
    order.update(order_params)
    respond_with order do |format|
      format.html { redirect_to order, notice: 'Order successfully updated.' }
      format.json { render json: order, include: [ order_lines: { include: [ jars: { include: [ :lot ] } ] } ] }
    end
  end

  def fulfill
    if request.post?
      @jar = Jar.find(params.require(:order)[:jar])
      @bag = Bag.find(params.require(:order)[:bag])
      @jar.weight = (params.require(:order)[:weight]).to_d

      if Transaction.from( @bag ).to( @jar ).take( @jar.weight ).by( current_user ).commit
        @jar.update(fulfilled: true)
        @bag.save
        @jar.save
      end

    else
      @jar = order.first_unfulfilled
      @bag = @jar.bag
      respond_to do |format|
        format.html
      end
    end
  end

  def destroy 
    order.destroy
    respond_with(order)
  end

  private

    def order_params
      params.require(:order).permit(:customer, :shipped_at, :ordered_at, :jar, :bag, :weight, :ces_order_id, :created_by, :placed_by,
      order_lines_attributes: [ :id, :brand_id, :jar_id, :quantity ])
    end

end
