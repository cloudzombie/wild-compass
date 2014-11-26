class PotsController < ApplicationController
  
  expose(:pot, params: :pot_params) do
    unless params[:id].nil?
      Pot.find(params[:id])
    else
      Pot.new
    end
  end

  expose(:pots) { Pot.all }

  def create
    self.pot = Pot.new(pot_params)

    respond_to do |format|
      if pot.save
        format.html { redirect_to pot, notice: 'Pot was successfully created.' }
        format.json { render :show, status: :created, location: pot }
      else
        format.html { render :new }
        format.json { render json: pot.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if pot.update(pot_params)
        format.html { redirect_to pot, notice: 'Pot was successfully updated.' }
        format.json { render :show, status: :ok, location: pot }
      else
        format.html { render :edit }
        format.json { render json: pot.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    pot.destroy
    respond_to do |format|
      format.html { redirect_to pots_url, notice: 'Pot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def pot_params
      params[:pot]
    end
end
