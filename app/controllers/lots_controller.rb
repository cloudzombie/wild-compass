class LotsController < ApplicationController
  expose(:lot, params: :lot_params) do
    unless params[:id].nil?
      Lot.find(params[:id])
    else
      Lot.new
    end
  end

  expose(:lots) { Lot.all }

  def create
    self.lot = Lot.new(lot_params)

    respond_to do |format|
      if lot.save
        format.html { redirect_to lot, notice: 'Lot was successfully created.' }
        format.json { render :show, status: :created, location: lot }
      else
        format.html { render :new }
        format.json { render json: lot.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
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

  def destroy
    lot.destroy
    respond_to do |format|
      format.html { redirect_to lots_url, notice: 'Lot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def lot_params
      params[:lot]
    end
end
