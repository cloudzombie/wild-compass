class JarsController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  expose(:jar, params: :jar_params) { id_param.nil? ? Jar.new : Jar.find(id_param) }
  expose(:jars) { Jar.order(sort_column + ' ' + sort_direction) }

  def create
    self.jar = Jar.new(jar_params)
    jar.initial_weight = jar.current_weight
    respond_to do |format|
      jar.name = "#{SecureRandom.uuid}_jar_#{jar.bag.lot.strain}_#{Time.now.strftime('%m%y')}"
      if jar.save
        Transaction.from( jar.bag ).to( jar ).take( jar.initial_weight ).commit( initial: true )
        format.html { redirect_to jar, notice: 'jar was successfully created.' }
        format.json { render :show, status: :created, location: jar }
      else
        format.html { render :new }
        format.json { render json: jar.errors, status: :unprocessable_entity }
      end
    end
  end

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

  def destroy
    jar.destroy
    respond_to do |format|
      format.html { redirect_to jars_url, notice: 'jar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def jar_params
      params.require(:jar).permit( :current_weight, :bag_id, :name, :initial_weight)
    end

    def id_param
      params[:id]
    end

    def sort_column
      %w(id current_weight initial_weight created_at updated_at).include?(params[:sort]) ? params[:sort] : 'updated_at'
    end

    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
