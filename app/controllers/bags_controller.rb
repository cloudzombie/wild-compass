class BagsController < ApplicationController
  
  expose(:bag, params: :bag_params) do
    unless params[:id].nil?
      Bag.find(params[:id])
    else
      Bag.new
    end
  end

  expose(:bags) { Bag.all }

  def create
    self.bag = Bag.new(bag_params)

    respond_to do |format|
      if bag.save
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
      params[:bag]
    end
end
