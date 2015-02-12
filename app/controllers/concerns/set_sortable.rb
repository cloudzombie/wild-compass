module SetSortable
  extend ActiveSupport::Concern

  included do
    helper_method :sort_column, :sort_direction
  end

  def sort_column
    model_class.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  # Set sort direction to ascending or descending.
  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def model_class
    controller_name.classify.constantize
  end

end