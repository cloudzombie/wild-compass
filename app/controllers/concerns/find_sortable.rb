module FindSortable
  extend ActiveSupport::Concern

  def sort(resource)
    case resource

    when Bag.class
      case sort_column      
      when 'name', :name
        resource.select('DISTINCT(bags.id), bags.*')
                .search(params[:search])
                .order('LENGTH(bags.name), bags.name ' + sort_direction)
                .page(params[:page])
      
      when 'strain', :strain
        resource.select('DISTINCT(bags.id), bags.*')
                .search(params[:search])
                .joins(:strains)
                .merge( Strain.order(acronym: sort_direction.to_sym))
                .page(params[:page])
      
      when 'category', :category
        resource.select('DISTINCT(bags.id), bags.*')
                .search(params[:search])
                .joins(:container)
                .merge( Container.order(category: sort_direction.to_sym))
                .page(params[:page])
      
      else
        resource.select('DISTINCT(bags.id), bags.*')
                .search(params[:search])
                .order("bags.#{sort_column}" + ' ' + sort_direction)
                .page(params[:page])
      end
    
    else
      raise "Sort is not implemented for #{resource} yet..."
    end
  end

end