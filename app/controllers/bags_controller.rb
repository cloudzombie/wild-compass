class BagsController < ApplicationController
  include Authorizable
  include FindEncodable
  include SetWeightable
  include SetRecallable
  include SetQuarantineable
  include Scannable

  respond_to :html, :xml, :json

  helper_method :sort_column, :sort_direction
  
  expose(:bag, params: :bag_params) { find(Bag) }
  
  expose(:bags) { Bag.search(params[:search])
                     .sort(sort_column, sort_direction)
                     .page(params[:page]) }

  expose(:jar) { Jar.new }

  expose(:strains) { Strain.all }
  
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

    Transaction.from( bag.container ).to( bag ).take( bag.weight ).by( current_user ).commit

    respond_to do |format|
      if bag.save && bag.container.save
        format.html { redirect_to bag, notice: 'Bag was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def reweight
    if request.post?

      bag.weight      = bag_params[:weight].to_d
      bag.message     = bag_params[:message]
      bag.quantity    = bag_params[:weight].to_d
      bag.tare_weight = bag_params[:tare_weight].to_d + 0.3

      if Transaction.reweight( bag ).weight( bag.weight -= bag.tare_weight ).by( current_user ).because( bag.message ).commit
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
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def bag_params
      params.require(:bag).permit(
        :quantity,     :weight, :message,        :initial_weight,
        :container_id, :name,   :current_weight, :bin_id,
        :lot_id,       :tare_weight
      )
    end

    # Set column to sort in order.
    def sort_column
      %w(id strain status category name initial_weight current_weight created_at updated_at lot_id tested).include?(params[:sort]) ? params[:sort] : 'name'
    end

    # Set sort direction to ascending or descending.
    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end

end
