class Process::FulfillsController < ApplicationController
  
  def new
    @order = Order.find(params[:order_id])
    @fulfill = Wild::Compass::Process::Fulfill.new(params[:order_id])
  end

  def create
    @order = Order.find(params[:order_id])
    @fulfill = Wild::Compass::Process::Fulfill.new(params[:order_id])
  end

end
