class SeedsController < ApplicationController

  include Authorizable
  include Scannable
  include SetWeightable
  include SetSortable

  respond_to :html

  expose(:seed, params: :seed_params) { params[:id].nil? ? Seed.new.decorate : Seed.find(params[:id]).decorate }
  expose(:seeds) { Seed.search(params[:search]).sort(sort_column, sort_direction).page(params[:page]).decorate }

  expose(:recent) { seed.lots.order(updated_at: :desc).first }

  def create
    self.seed = Seed.new(seed_params).decorate
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

  def reweight
    if request.post?

      seed.weight      = seed_params[:weight].to_d
      seed.message     = seed_params[:message]
      seed.quantity    = seed_params[:weight].to_d

      if Transaction.reweight(seed).amount(seed.weight).by(current_user).because(seed.message).commit
        redirect_to seed, notice: 'Seed was successfully reweighted.'
      else
        redirect_to seed, notice: 'Seed was not successfully reweighted.'
      end

    else
      respond_to do |format|
        format.html
      end
    end
  end

  def datamatrix
    send_data seed.datamatrix, type: 'image/png', disposition: 'attachment'
  end

  def label
    respond_to do |format|
      format.html
    end
  end

  private

    def seed_params
      params.require(:seed).permit(:name, :stock, :weight, :message, :initial_weight, :seed, :current_weight, { plant_ids: [] })
    end

end
