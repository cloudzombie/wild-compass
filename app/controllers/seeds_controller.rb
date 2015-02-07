class SeedsController < ApplicationController

  respond_to :html

  expose(:seed, params: :seed_params) { params[:id].nil? ? Seed.new : Seed.find(params[:id]) }
  expose(:seeds) { Seed.all }

  def create
    self.seed = Seed.new(seed_params)
    seed.save
    respond_with(seed)
  end

  def update
    seed.update(seed_params)
    respond_with(seed)
  end

  def destroy
    seed.destroy
    respond_with(seed)
  end

  private

    def seed_params
      params.require(:seed).permit(:name, :stock)
    end

end
