class SeedsController < ApplicationController
  include Authorizable

  respond_to :html

  helper_method :sort_column, :sort_direction

  expose(:recent) { seed.lots.order(updated_at: :desc).first }
  expose(:seed, params: :seed_params) { params[:id].nil? ? Seed.new : Seed.find(params[:id]) }
  expose(:seeds) do
    if sort_column == 'name'
      Seed.search(params[:search]).sort_by('LENGTH(name), name ' + sort_direction).page(params[:page])
    elsif Seed.column_names.include? sort_column
      Seed.search(params[:search]).order( sort_column + ' ' + sort_direction ).page(params[:page])
    end
  end

  def create
    self.seed = Seed.new(seed_params)
    seed.save
    respond_with(seed)
  end

  def update
    seed.update(seed_params)
    respond_with(seed)
  end

  def destroy
    seed.destroy
    respond_with(seed)
  end

  private

    def seed_params
      params.require(:seed).permit(:name, :stock, :initial_weight, :current_weight, { plant_ids: [] })
    end


    # Set column to sort in order.
    def sort_column
      %w(id name initial_weight current_weight created_at updated_at).include?(params[:sort]) ? params[:sort] : 'created_at'
    end

    # Set sort direction to ascending or descending.
    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end

end
