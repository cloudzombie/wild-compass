class ContainersController < ApplicationController

  include SetWeightable
  
  helper_method :sort_column, :sort_direction

  before_action :authorized?

  expose(:container, params: :container_params) { id_param.nil? ? Container.new : Container.find(id_param) }

  expose(:containers) do
    if sort_column == 'name'
      Container.search(params[:search]).sort_by('LENGTH(name), name ' + sort_direction).page(params[:page])
    elsif Container.column_names.include? sort_column
      Container.search(params[:search]).order( sort_column + ' ' + sort_direction ).page(params[:page])
    elsif sort_column == 'strain'
      Container.search(params[:search]).joins(:strains).merge(Strain.order(acronym: sort_direction.to_sym)).page(params[:page])
    elsif sort_column == 'lot_id'
      Container.search(params[:search]).joins(:lots).merge(Lot.order(id: sort_direction.to_sym)).page(params[:page])
    end
  end

  expose(:plants) { Plant.order(id: :asc) }

  def create
    self.container = Container.new(container_params)

    Transaction.from( container.plant ).to( container ).take( container.weight ).by( current_user ).commit

    respond_to do |format|
      if container.save
        format.html { redirect_to container, notice: 'Container was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end 

  def update
    params[:container][:plant_ids] ||= []
    respond_to do |format|
      if container.update(container_params)
        format.html { redirect_to container, notice: 'Container was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    container.destroy
    respond_to do |format|
      format.html { redirect_to containers_url, notice: 'Container was successfully destroyed.' }
    end
  end


  private

    def authorized?
      authorize! action_name.to_sym, Container
    end

    def id_param
      params[:id]
    end

    def container_params
      params.require(:container).permit(:name, :lot_id, :location_id, :category, :current_weight, :initial_weight, :weight, { plant_ids: [] })
    end

    # Set column to sort in order.
    def sort_column
      %w(id lot_id strain category location name initial_weight current_weight created_at updated_at container_id).include?(params[:sort]) ? params[:sort] : 'created_at'
    end

    # Set sort direction to ascending or descending.
    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
