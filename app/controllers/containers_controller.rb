class ContainersController < ApplicationController
  include Authorizable
  include SetWeightable
  
  helper_method :sort_column, :sort_direction

  expose(:container, params: :container_params) { id_param.nil? ? Container.new : Container.find(id_param) }

  expose(:containers) { Container::Stage2Container.search(params[:search])
                                                  .sort(sort_column, sort_direction)
                                                  .page(params[:page]) }
  #   if sort_column == 'name'
  #     Container::Stage2Container.search(params[:search]).order('LENGTH(name), name ' + sort_direction).page(params[:page])
  #   Container::Stage2Container.column_names.include? sort_column
  #     Container::Stage2Container.search(params[:search]).order( sort_column + ' ' + sort_direction ).page(params[:page])
  #   elsif sort_column == 'strain'
  #     Container::Stage2Container.search(params[:search]).joins(:strains).merge(Strain.order(name: sort_direction.to_sym)).page(params[:page])
  #   elsif sort_column == 'lot_id'
  #     Container::Stage2Container.search(params[:search]).joins(:lots).merge(Lot.order(id: sort_direction.to_sym)).page(params[:page])
  #   else
  #     Container::Stage2Container.search(params[:search]).page(params[:page])
  #   end
  # end

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
