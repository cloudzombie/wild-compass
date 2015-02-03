module FindSortable
  extend ActiveSupport::Concern

  def sort(resource)
    case sort_column      
    when 'name', :name
      resource.search(params[:search]).order('LENGTH(name), name ' + sort_direction).page(params[:page])
    when 'strain', :strain
      resource.search(params[:search]).joins(:strains).merge(Strain.order(acronym: sort_direction.to_sym)).page(params[:page])
    when 'category', :category
      resource.search(params[:search]).joins(:container).merge(Container.order(category: sort_direction.to_sym)).page(params[:page])
    else
      resource.search(params[:search]).order(sort_column + ' ' + sort_direction).page(params[:page])
    end
  end

end