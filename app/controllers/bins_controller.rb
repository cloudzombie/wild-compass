class BinsController < ApplicationController
  before_action :set_bin, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @bins = Bin.all
    @bin = Bin.new
    respond_with(@bins)
  end

  def show
    respond_with(@bin)
  end

  def new
    @bin = Bin.new
    respond_with(@bin)
  end

  def edit
  end

  def create
    @bin = Bin.new(bin_params)
    @bin.save
    respond_with(@bin)
  end

  def update
    @bin.update(bin_params)
    respond_with(@bin)
  end

  def destroy
    @bin.destroy
    respond_with(@bin)
  end

  private
    def set_bin
      @bin = Bin.find(params[:id])
    end

    def bin_params
      params.require(:bin).permit(:name, :location_id)

    end
end
