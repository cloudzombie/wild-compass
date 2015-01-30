class LocationsController < ApplicationController

  before_action :authorized?

  before_action :set_location, only: [:show, :edit, :update, :destroy]

  expose(:plant)
  expose(:bin)
  expose(:container)
  
  expose(:locations)
  expose(:location, params: :location_params)

  respond_to :html

  def create
    self.location = Location.new(location_params)
    location.save
    respond_with(location)
  end

  def update
    location.update(location_params)
    respond_with(location)
  end

  def destroy
    location.destroy
    respond_with(location)
  end

  private

    def authorized?
      authorize! action_name.to_sym, Location
    end

    def set_location
      location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:name, :description, :plant_ids, :bin_ids, :container_ids)
    end
end
