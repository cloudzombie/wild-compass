class BinsController < ApplicationController

  respond_to :html, :xml, :json

  before_action :authorized?

  expose(:bin, params: :bin_params) { id_param.nil? ? Bin.new : Bin.find(id_param) }
  expose(:bins) { Bin.all }

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

    def authorized?
      authorize! action_name.to_sym, Bin
    end

    def id_param
      params[:id]
    end

    def bin_params
      params.require(:bin).permit(:name, :location_id)
    end
end
