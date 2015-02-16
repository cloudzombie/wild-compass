class ContainersController < ApplicationController
  include Authorizable
  include SetWeightable
  include SetSortable

  expose(:container, params: :container_params) { id_param.nil? ? Container.new : Container.find(id_param) }

  expose(:containers) { Container.search(params[:search])
                                 .sort(sort_column, sort_direction)
                                 .page(params[:page]) }

  expose(:plants) { Plant.order(id: :asc) }

  def create
    self.container = Container.new(container_params)

    TransactionManager.from( container.plant ).to( container ).take( container.weight ).by( current_user ).commit

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
      params.require(:container).permit(:name, :lot_id, :location_id, :category, :current_weight, :initial_weight, :weight, :type, { plant_ids: [] })
    end
    
end
