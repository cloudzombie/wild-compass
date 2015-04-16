require 'csv'
require 'wild/compass/template/engine'

class LotsController < ApplicationController

  include Authorizable
  include SetRecallable
  include SetQuarantineable
  include SetReleasable
  include SetSortable

  expose(:lot, params: :lot_params) { params[:id].nil? ? Lot.new.decorate : Lot.find(params[:id]).decorate }
  expose(:lots) { Lot.search(params[:search]).sort(sort_column, sort_direction).page(params[:page]).decorate }

  expose(:engine) do
    Wild::Compass::Template::Engine.load(Lot) do |config|
      config.unload :origin
      config.unload :initial_weight
    end
  end

  expose(:containers) { Container.order(id: :asc) }
  expose(:recent) { lot.containers.order(updated_at: :desc).first }

  expose(:bags) { lot.bags }
  expose(:bag) { Bag.new }
  
  # Create new lot.
  def create 
    self.lot = Lot.new(lot_params)

    respond_to do |format|
      if lot.save
        format.html { redirect_to lot, notice: 'Lot was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # Update lot column.
  def update
    params[:lot][:container_ids] ||= []

    respond_to do |format|
      if lot.update(lot_params)
        format.html { redirect_to lot, notice: 'Lot was successfully updated.' }
        format.json { render :show, status: :ok, location: lot }
      else
        format.html { render :edit }
        format.json { render json: lot.errors, status: :unprocessable_entity }
      end
    end
  end

  # Destroy lot.
  def destroy 
    lot.destroy
    respond_to do |format|
      format.html { redirect_to lots_url, notice: 'Lot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def relot
  end

  def report
    self.lots = Lot.all
    respond_to do |format|
      format.csv { send_data lots.to_csv }
    end
  end

  private

    def lot_params
      params.require(:lot).permit(:name, :weight, :initial_weight, :strain_id, :current_weight,
                                  :thc_composition, :cbd_composition, :cbn_composition, { container_ids: [] })
    end

end
