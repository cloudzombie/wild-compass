class OrdersController < ApplicationController
  # Expose sort_column and sort_direction private methods as helper methods
  # to make them available in views
  helper_method :sort_column, :sort_direction

  # Expose order and orders for views to manipulate
  # If no id is specified, a new order is instanciated (not created)
  expose(:order, params: :order_params) { id_param.nil? ? Order.new : Order.find(id_param) }
  # Match given sort parameters against database columns
  expose(:orders) { Order.order(sort_column + ' ' + sort_direction) }

  respond_to :html, :json, :xml

  def new
    order.order_lines.build
  end

  ##
  # Creates a new order from a POST HTTP request.
  # 
  # POST /orders/create
  # +Examples+::
  # * POST localhost:3000/orders/create?customer="John Doe"&ordered_at="2015-01-02T17:01:12-05:00"&shipped_at="2015-01-02T17:01:12-05:00"&order_lines_attributes=
  # * POST ics.thc.vc/orders/create?customer="Foo Bar"&ordered_at="2015-01-02T17:01:12-05:00"&shipped_at="2015-01-02T17:01:12-05:00"&order_lines_attributes=
  #
  # +order_params+::
  # * customer: string
  # * ordered_at: datetime
  # * shipped_at: datetime
  # * order_lines_attributes: OrderLine[]
  #
  # +OrderLine+::
  # * product_id: integer
  # * product_type: string
  # * quantity: integer
  #
  def create
    self.order = Order.new(order_params)
    order.save
    respond_with(order)
  end

  ##
  # Updates an existing order with a PATCH or PUT HTTP request
  #
  # PATCH /orders/:id
  # +Examples+::
  # * PUT localhost:3000/orders/1?customer="John Doe"&ordered_at="2015-01-02T17:01:12-05:00"&shipped_at="2015-01-02T17:01:12-05:00"&order_lines_attributes=
  # * PATCH ics.thc.vc/orders/1?customer="Foo Bar"&ordered_at="2015-01-02T17:01:12-05:00"&shipped_at="2015-01-02T17:01:12-05:00"&order_lines_attributes=
  #
  # +order_params+::
  # * customer: string
  # * ordered_at: datetime
  # * shipped_at: datetime
  # * order_lines_attributes: OrderLine[]
  #
  # +OrderLine+::
  # * product_id: integer
  # * product_type: string
  # * quantity: integer
  #
  def update 
    order.update(order_params)
    respond_with(order)
  end

  ##
  # Destroys an order with a DELETE HTTP request
  # id: integer
  #
  # DELETE /orders/:id
  # +Examples+::
  # * DELETE localhost:3000/orders/1
  # * DELETE ics.thc.vc/orders/42
  #
  def destroy 
    order.destroy
    respond_with(order)
  end

  private

    def id_param
      params[:id]
    end

    def order_params
      params.require(:order).permit(:customer, :shipped_at, :ordered_at, order_lines_attributes: [ :id, :brand_id, :jar_id, :quantity ])
    end

    # Set column to sort in order
    def sort_column
      %w(id customer total_weight ordered_at shipped_at).include?(params[:sort]) ? params[:sort] : 'ordered_at'
    end

    # Set sort direction to ascending or descending
    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end

end
