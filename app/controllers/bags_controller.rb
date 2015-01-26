class BagsController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  expose(:bag, params: :bag_params) { id_param.nil? ? Bag.new : find_bag }
  
  expose(:bags) do
    if sort_column == 'name'
      Bag.search(params[:search]).order('LENGTH(name), name ' + sort_direction).page(params[:page])
    elsif Bag.column_names.include? sort_column
      Bag.search(params[:search]).order(sort_column + ' ' + sort_direction).page(params[:page])
    elsif sort_column == 'strain'
      Bag.search(params[:search]).joins(:strains).merge(Strain.order(acronym: sort_direction.to_sym)).page(params[:page])
    elsif sort_column == 'category'
      Bag.search(params[:search]).joins(:containers).merge(Container.order(category: sort_direction.to_sym)).page(params[:page])
    else
      Bag.search(params[:search]).page(params[:page])
    end
  end

  expose(:jar) { Jar.new }
  
  before_action :set_weight, only: [ :create, :update, :reweight ]
  before_action :set_name, only: [ :create, :update , :reweight]
  before_action :set_quantity, only: [ :create, :update, :reweight ]

  respond_to :html, :xml, :json

  ##
  # Create a new bag from a POST HTTP request with given parameters:
  # +bag_params+::
  # * current_weight: decimal
  # * current_weight: decimal
  # * container_id: integer
  # * name: string (optional)
  #
  def create
    self.bag = Bag.new(bag_params)
    authorize! :create, bag

    Transaction.from( bag.lot ).to( bag ).take( bag.weight ).by( current_user ).commit

    respond_to do |format|
      if bag.save && bag.lot.save
        format.html { redirect_to bag, notice: 'Bag was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def reweight
    authorize! :reweight, bag
    
    if request.post?
    
      if Transaction.reweight( bag ).weight( bag.weight ).by( current_user ).commit
        redirect_to bag, notice: 'Bag was successfully reweighted.'
      else
        redirect_to bag, notice: 'Bag was not successfully reweighted.'
      end

    else

      respond_to do |format|
        format.html
      end

    end
  end

  # Update bag column.
  def update
    authorize! :update, bag

    respond_to do |format|
      if bag.update(bag_params)
        format.html { redirect_to bag, notice: 'Bag was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # Destroy bag.
  def destroy
    authorize! :destroy, bag

    bag.destroy
    respond_to do |format|
      format.html { redirect_to bags_url, notice: 'Bag was successfully destroyed.' }
    end
  end



  def datamatrix
    send_data bag.datamatrix, type: 'image/png', disposition: 'attachment'
  end



  def label
    respond_to do |format|
      format.html
      format.js
    end
  end



  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def bag_params
      params.require(:bag).permit(:quantity, :weight, :initial_weight, :lot_id, :name, :current_weight, :bin_id)
    end

    def id_param
      params[:id]
    end

    def find_bag
      Bag.find(id_param) || Bag.find_by(datamatrix_hash: id_param)
    end

    # Set column to sort in order.
    def sort_column
      %w(id strain category name initial_weight current_weight created_at updated_at lot_id tested).include?(params[:sort]) ? params[:sort] : 'name'
    end

    # Set sort direction to ascending or descending.
    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end

    # Set bag name.
    def set_name
      if bag.name.nil? || bag.name.empty?
        bag.name = "B-#{acronym}#{Time.now.strftime('%d%m%y')}"
      end
    end

    def set_weight
      if bag.weight.nil?
        bag.weight = 0.0
      else
        bag.weight = bag.weight.to_d
      end
    end

    def set_quantity
      if bag.quantity.nil?
        bag.quantity = 0.0
      else
        bag.quantity = bag.quantity.to_d
      end
    end

    def acronym
      #Bag.find(id_param).strain.acronym
    end
end
