class ContainersController < ApplicationController

  before_action :set_container, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @containers = Container.all
    @container = Container.new
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
    @container = Container.new(container_params)
    if @container.weight.nil?
      @container.weight = 0.0
    else
      @container.weight = @container.weight.to_d
    end
    authorize! :create, @container
    
    Transaction.from( @container.lot ).to( @container ).take( @container.weight ).by( current_user ).commit

    respond_to do |format|
      if @container.save && @container.lot.save
        format.html { redirect_to @container, notice: 'Container was successfully created.' }
      else
        format.html { render :new }
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
      params.require(:container).permit(:name, :lot_id, :current_weight, :initial_weight, :weight)
    end
end
