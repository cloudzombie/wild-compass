class BinsController < ApplicationController

  include Authorizable
  include FindEncodable
  include SetSortable

  respond_to :html, :xml, :json

  expose(:bin, params: :bin_params) { find(Bin).decorate }
  expose(:bins) { Bin.search(params[:search]).sort(sort_column, sort_direction).page(params[:page]).decorate }

  def create
    self.bin = Bin.new(bin_params)
    bin.save
    respond_with(bin)
  end

  def update
    bin.update(bin_params)
    respond_with(bin)
  end

  def destroy
    bin.destroy
    respond_with(bin)
  end

  def label
    respond_to do |format|
      format.html
    end
  end



  private

    def id_param
      params[:id]
    end

    def bin_params
      params.require(:bin).permit(:name, :location_id, { bag_ids: [] })
    end
    
end
