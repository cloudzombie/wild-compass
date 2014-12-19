class BagsController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  expose(:bag, params: :bag_params) { id_param.nil? ? Bag.new : Bag.find(id_param) }
  expose(:bags) { Bag.order(sort_column + ' ' + sort_direction) }

  def create
    self.bag = Bag.new(bag_params)
    bag.current_weight =  bag.initial_weight
    respond_to do |format|
      bag.name = "#{SecureRandom.uuid}_Bag#{bag.lot.strain}#{Time.now.strftime("%m%y")}"
      if bag.save
        Transaction.from( bag.lot).to( bag ).take( bag.initial_weight ).commit( initial: true )
        format.html { redirect_to bag, notice: 'Bag was successfully created.' }
        format.json { render :show, status: :created, location: bag }
      else
        format.html { render :new }
        format.json { render json: bag.errors, status: :unprocessable_entity }
      end
    end
  end 

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
      params.require(:bag).permit(:initial_weight, :lot_id, :name, :created_a, :current_weight)
    end

    def id_param
      params[:id]
    end

    def sort_column
      %w(id initial_weight current_weight created_at updated_at lot_id).include?(params[:sort]) ? params[:sort] : 'created_at'
    end

    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
