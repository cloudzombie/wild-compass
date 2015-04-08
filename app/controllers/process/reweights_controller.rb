class Process::ReweightsController < ApplicationController
  
  expose(:reweight) { Reweight.new(Bag.find(params[:bag_id])) }

  def new
  end

  def create
  end

end
