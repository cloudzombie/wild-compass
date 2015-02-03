class LotsController < ApplicationController

  before_action :authorized?

  helper_method :sort_column, :sort_direction

  expose(:lot, params: :lot_params) { id_param.nil? ? Lot.new : Lot.find(id_param) }

  expose(:lots) do
    if Lot.column_names.include? sort_column
      Lot.search(params[:search]).order(sort_column + ' ' + sort_direction).page(params[:page])
    else
      Lot.search(params[:search]).joins(:strain).merge(Strain.order(acronym: sort_direction.to_sym)).page(params[:page])
    end
  end

  expose(:containers) { Container.order(id: :asc) }
  expose(:recent) { Container.order(updated_at: :desc).first }
  expose(:bag) { Bag.new }
  
  # Create new lot.
  def create 
    self.lot = Lot.new(lot_params)

    Transaction.from( nil ).to( lot ).take( lot.weight ).by( current_user ).commit

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

  private

    def lot_params
      params.require(:lot).permit(:name, :weight, :initial_weight, :strain_id, :current_weight,
                                  :thc_composition, :tbd_composition, { container_ids: [] })
    end

    def id_param
      params[:id]
    end

    # Set column to sort in order.
    def sort_column
      %w(id name category strain initial_weight current_weight created_at updated_at thc_composition tbd_composition).include?(params[:sort]) ? params[:sort] : 'id'
    end

    # Set sort direction to ascending or descending.
    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end

    def authorized?
      authorize! action_name.to_sym, Lot
    end
end
