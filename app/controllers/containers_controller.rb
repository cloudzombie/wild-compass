class ContainersController < ApplicationController

  before_action :set_container, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @containers = Container.all
    respond_with(@containers)
  end

  def show
    respond_with(@container)
  end

  def new
    @container = Container.new
    respond_with(@container)
  end

  def edit
  end

  def create
    @container = Container.new(@container_params)
    authorize! :create, @container

    respond_to do |format|
      if @container.save && @container.lot.save
        
        format.html { redirect_to @container, notice: 'Container was successfully created.' }
        format.json { render :show, status: :created, location: @container }
      else
        format.html { render :new }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end 

  def update
    @container.update(container_params)
    respond_with(@container)
  end

  def destroy
    @container.destroy
    respond_with(@container)
  end

  private
    def set_container
      @container = Container.find(params[:id])
    end

    def container_params
      params.require(:container).permit(:name, :lot_id, :current_weight, :initial_weight)
    end
end
