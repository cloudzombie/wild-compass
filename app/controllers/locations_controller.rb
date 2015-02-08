class LocationsController < ApplicationController

  before_action :authorized?

  expose(:plant)
  expose(:bin)
  expose(:container)
  
  expose(:locs) { Location.all }
  expose(:loc, params: :loc_params) { params[:id].nil? ? Location.new : Location.find(params[:id]) }

  respond_to :html

  def create
    self.loc = Location.new(loc_params)
    loc.save
    respond_with(loc)
  end

  def update
    loc.update(loc_params)
    respond_with(loc)
  end

  def destroy
    loc.destroy
    respond_with(loc)
  end

  private

    def authorized?
      authorize! action_name.to_sym, Location
    end

    def loc_params
      params.require(:location).permit(:name, :description, :plant_ids, :bin_ids, :container_ids)
    end
end
