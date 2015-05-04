class WeightsController < ApplicationController

  respond_to :html

  expose(:bag) { params[:bag_id].nil? ? nil : Bag.find(params[:bag_id]) }
  expose(:container) { params[:container_id].nil? ? nil : Container.find(params[:container_id]) }
  expose(:jar) { params[:jar_id].nil? ? nil : Jar.find(params[:jar_id]) }
  expose(:lot) { params[:lot_id].nil? ? nil : Lot.find(params[:lot_id]) }
  expose(:plant) { params[:plant_id].nil? ? nil : Plant.find(params[:plant_id]) }
  expose(:seed) { params[:seed_id].nil? ? nil : Seed.find(params[:seed_id]) }

  expose(:weight, params: :weight_params) { params[:id].nil? ? Weight.new : Weight.find(params[:id]) }
  expose(:weights) { weights_for_resource }

  def create
    self.weight = Weight.new(weight_params)
    weight.save
    respond_with(weight)
  end

  def update
    weight.update(weight_params)
    respond_with(weight)
  end

  def destroy
    weight.destroy
    respond_with(weight)
  end

  private

    def weight_params
      params.require(:weight).permit(:weighted_at, :value)
    end

    def weights_for_resource
      resources = Weight.none
      [bag, container, jar, lot, plant, seed].each do |resource|
        if resource
          resources = Weight.all.merge(resource.weights) 
        else
          next
        end
      end
      resources
    end

end
