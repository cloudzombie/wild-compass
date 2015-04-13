class JarsController < ApplicationController
  
  include Authorizable
  include FindEncodable
  include SetWeightable
  include SetReturnable
  include SetDestroyable
  include SetSendableToLab

  helper_method :sort_column, :sort_direction
  
  expose(:jar, params: :jar_params) { find(Jar) }

  expose(:jars) { Jar.search(params[:search]).sort(sort_column, sort_direction).page(params[:page]) }

  # Create new jar.
  def create 
    self.jar = Jar.new(jar_params)

    respond_to do |format|
      if jar.save && jar.bag.save
        format.html { redirect_to jar, notice: 'jar was successfully created.' }
        format.json { render :show, status: :created, location: jar }
      else
        format.html { render :new }
        format.json { render json: jar.errors, status: :unprocessable_entity }
      end
    end
	
  end
  
  # Update jar column.
  def update 
    respond_to do |format|
      if jar.update(jar_params) 
        format.html { redirect_to jar, notice: 'jar was successfully updated.' }
        format.json { render :show, status: :ok, location: jar }
      else
        format.html { render :edit }
        format.json { render json: jar.errors, status: :unprocessable_entity }
      end
    end
  end

  # Destroy jar.
  def destroy 
    jar.destroy
    respond_to do |format|
      format.html { redirect_to jars_url, notice: 'jar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def datamatrix
    send_data jar.datamatrix, type: 'image/png', disposition: 'attachment'
  end

  def label
    respond_to do |format|
      format.html
    end
  end

  def scan
    respond_to do |format|
      format.html { redirect_to jars_path, notice: "#{self.jar == Jar.find_by(datamatrix_hash: jar_params[:scanned_hash])}" }
      format.json do
        render json: {
          jar: {
            match: self.jar == Jar.find_by(datamatrix_hash: jar_params[:scanned_hash])
          }
        } 
      end
    end
  end



  # Never trust parameters from the scary internet, only allow the white list through.
  private
    def jar_params
      params.require(:jar).permit(:weight, :ordered_amount, :current_weight, :bag_id, :name, :initial_weight, :scanned_hash)
    end

    def id_param
      params[:id]
    end

    # Set column to sort in order.
    def sort_column
      %w(id strain category origin current_weight bag_id created_at updated_at).include?(params[:sort]) ? params[:sort] : 'name'
    end

    # Set sort direction to ascending or descending.
    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end

end
