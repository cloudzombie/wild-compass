class ContainersController < ApplicationController
  helper_method :sort_column, :sort_direction

  expose(:container, params: :container_params) { id_param.nil? ? Container.new : Container.find(id_param) }
  
  expose(:containers) do
    if Container.column_names.include? sort_column
      Container.order( sort_column + ' ' + sort_direction ).page(params[:page])
    elsif sort_column == 'strain'
      Container.joins(:strains).merge(Strain.order(acronym: sort_direction.to_sym)).page(params[:page])
    elsif sort_column == 'lot_id'
      Container.joins(:lots).merge(Lot.order(id: sort_direction.to_sym)).page(params[:page])
    end
  end

  expose(:plants) { Plant.order(id: :asc) }

  before_action :set_weight, only: [ :create, :update ]

  def create
    self.container = Container.new(container_params)
    authorize! :create, container

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
    authorize! :update, container
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
    authorize! :destroy, container

    container.destroy
    respond_to do |format|
      format.html { redirect_to containers_url, notice: 'Container was successfully destroyed.' }
    end
  end

  private

    def id_param
      params[:id]
    end

    def container_params
      params.require(:container).permit(:name, :category, :current_weight, :initial_weight, :weight, { plant_ids: [] })
    end

    def set_weight
      if container.weight.nil?
        container.weight = 0.0
      else
        container.weight = container.weight.to_d
      end
    end

    # Set column to sort in order.
    def sort_column
      %w(id lot_id strain category name initial_weight current_weight created_at updated_at container_id).include?(params[:sort]) ? params[:sort] : 'created_at'
    end

    # Set sort direction to ascending or descending.
    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
