class BinsController < ApplicationController

  include Authorizable
  include FindEncodable
  include SetSortable

  respond_to :html, :xml, :json

  expose(:bin, params: :bin_params) { find(Bin).decorate }
  expose(:bins) { Bin.search(params[:search]).sort(sort_column, sort_direction).page(params[:page]).decorate }

  expose(:locations) { Location.all.decorate }
  expose(:bags) { Bag.all.decorate }

  def create
    self.bin = Bin.new(bin_params)
    bin.save
    respond_with(bin)
  end

  def update
    params[:bin][:bag_ids] ||= []

    respond_to do |format|
      if bin.update(bin_params)
        format.html { redirect_to bin, notice: 'Bin was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
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
