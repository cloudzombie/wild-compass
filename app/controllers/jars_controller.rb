class JarsController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  expose(:jar, params: :jar_params) { id_param.nil? ? Jar.new : Jar.find(id_param) }

  expose(:jars) do
    if Jar.column_names.include? sort_column
      Jar.order(sort_column + ' ' + sort_direction)
    elsif sort_column == 'strain'
      Jar.joins(:strain).merge(Strain.order(acronym: sort_direction.to_sym))
    elsif sort_column == 'category'
      Jar.joins(:lot).merge(Lot.order(category: sort_direction.to_sym))
    end
  end

  before_action :set_weight, only: [ :create, :update ]
  before_action :set_name, only: [ :create, :update ]
  before_action :set_quantity, only: [ :create, :update ]

  # Create new jar.
  def create 
    self.jar = Jar.new(jar_params)

    Transaction.from( jar.bag ).to( jar ).take( jar.weight ).by( current_user ).commit

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

  # Never trust parameters from the scary internet, only allow the white list through.
  private
    def jar_params
      params.require(:jar).permit(:weight, :current_weight, :bag_id, :name, :initial_weight)
    end

    def id_param
      params[:id]
    end

    # Set column to sort in order.
    def sort_column
      %w(id strain category origin current_weight bag_id created_at updated_at).include?(params[:sort]) ? params[:sort] : 'updated_at'
    end

    # Set sort direction to ascending or descending.
    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end

    def set_weight
      if jar.weight.nil?
        jar.weight = 0.0
      else
        jar.weight = jar.weight.to_d
      end
    end

    def set_quantity
      if jar.quantity.nil?
        jar.quantity = 0.0
      else
        jar.quantity = jar.quantity.to_d
      end
    end

    def set_name
      if jar.name.nil? || jar.name.empty?
        jar.name = "J-#{bag_name}-#{Time.now.strftime('%d%m%y')}"
      end
    end

    def bag_name
      Bag.find(jar_params[:bag_id])
    end
end
