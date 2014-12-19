class LotsController < ApplicationController
  helper_method :sort_column, :sort_direction

  expose(:lot, params: :lot_params) { id_param.nil? ? Lot.new : Lot.find(id_param) }
  expose(:lots) { Lot.order(sort_column + ' ' + sort_direction) }
  expose(:bag) { Bag.new }
  
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
      params.require(:lot).permit(:name, :current_weight)
    end

    def id_param
      params[:id]
    end

    def sort_column
      %w(id name initial_weight current_weight created_at updated_at).include?(params[:sort]) ? params[:sort] : 'updated_at'
    end

    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
