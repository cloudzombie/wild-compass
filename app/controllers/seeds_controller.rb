class SeedsController < ApplicationController
  before_action :set_seed, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @seeds = Seed.all
    respond_with(@seeds)
  end

  def show
    respond_with(@seed)
  end

  def new
    @seed = Seed.new
    respond_with(@seed)
  end

  def edit
  end

  def create
    @seed = Seed.new(seed_params)
    @seed.save
    respond_with(@seed)
  end

  def update
    @seed.update(seed_params)
    respond_with(@seed)
  end

  def destroy
    @seed.destroy
    respond_with(@seed)
  end

  private
    def set_seed
      @seed = Seed.find(params[:id])
    end

    def seed_params
      params.require(:seed).permit(:name)
    end
end
