class BagsController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  expose(:bag, params: :bag_params) { id_param.nil? ? Bag.new : Bag.find(id_param) }
  
  expose(:bags) do
    if Bag.column_names.include? sort_column
      Bag.order(sort_column + ' ' + sort_direction)
    elsif sort_column == 'strain'
      Bag.joins(:strain).merge(Strain.order(acronym: sort_direction.to_sym))
    elsif sort_column == 'category'
      Bag.joins(:lot).merge(Lot.order(category: sort_direction.to_sym))
    end
  end

  expose(:jar) { Jar.new }

  ##
  # Create a new bag from a POST HTTP request with given parameters:
  # +bag_params+::
  # * current_weight: decimal
  # * current_weight: decimal
  # * lot_id: integer
  # * name: string (optional)
  #
  def create
    self.bag = Bag.new(bag_params)

    set_weight
    set_name if bag.name.nil? || bag.name.empty?

    respond_to do |format|
      if bag.save
        Transaction.from( bag.lot).to( bag ).take( bag.weight ).commit( initial: true )
        format.html { redirect_to bag, notice: 'Bag was successfully created.' }
        format.json { render :show, status: :created, location: bag }
      else
        format.html { render :new }
        format.json { render json: bag.errors, status: :unprocessable_entity }
      end
    end
  end 

  # Update bag column.
  def update
    respond_to do |format|
      if bag.update(bag_params)
        format.html { redirect_to bag, notice: 'Bag was successfully updated.' }
        format.json { render :show, status: :ok, location: bag }
      else
        format.html { render :edit }
        format.json { render json: bag.errors, status: :unprocessable_entity }
      end
    end
  end

  # Destroy bag.
  def destroy
    bag.destroy
    respond_to do |format|
      format.html { redirect_to bags_url, notice: 'Bag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def bag_params
      params.require(:bag).permit(:weight, :initial_weight, :lot_id, :name, :created_a, :current_weight)
    end

    def id_param
      params[:id]
    end

    # Set column to sort in order.
    def sort_column
      %w(id strain category name initial_weight current_weight created_at updated_at).include?(params[:sort]) ? params[:sort] : 'created_at'
    end

    # Set sort direction to ascending or descending.
    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end

    # Set bag name.
    def set_name
      bag.name = "B-#{bag.lot.strain.acronym}#{Time.now.strftime('%d%m%y')}"
    end

    # Set bag weight.
    def set_weight
      bag.weight = bag.weight.to_d
      bag.current_weight = bag.initial_weight = bag.weight
    end
end
