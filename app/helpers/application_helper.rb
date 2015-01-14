module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.to_s.titleize
    current = column.to_s == sort_column ? true : false
    css_class = current ?  'current' : nil
    direction = current && sort_direction == 'asc' ? 'desc' : 'asc'
    if current
      chevron = fa_icon(sort_direction == 'desc' ? 'chevron-down' : 'chevron-up')
      link_to "#{title} #{chevron}".html_safe, { sort: column, direction: direction }, { class: css_class }
    else
      link_to title, { sort: column, direction: direction }
    end
  end

  def percent_of_weight(weightable)
    number_with_precision(
      weightable.try(:current_weight).to_d / weightable.try(:initial_weight).to_d * 100,
      precision: 2
    )
  rescue
    '0.00'
  end


  def display_error_for(model, attribute)
    return '' if model.errors[attribute].empty?
    out = ''
    model.errors[attribute].each do |message|
      out << "<li class=\"text-danger\">#{attribute.to_s.humanize} #{message}</li>\n"
    end
    "<ul style=\"list-style-type: none; padding-left: 0;\">\n
      #{out}
    </ul>\n".html_safe
  end
 
  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"   # Green
      when "error"
        "alert-danger"    # Red
      when "alert"
        "alert-warning"   # Yellow
      when "notice"
        "alert-info"      # Blue
      else
        flash_type.to_s
    end
  end

  def weight_for(weight, g = ' g')
    if weight.nil?
      "0.00#{g}"
    else
      "#{number_with_precision weight.to_d, precision: 2 }#{g}"
    end
  rescue
    ''
  end

  def date_for(datetime)
    datetime.to_s(:short)
  rescue
    ''
  end

  def strains_for(strains)
    output = ''
    strains.uniq.each do |strain|
      output << "<small class=\"label label-default\">#{strain}</small> "
    end
    output.html_safe
  rescue
    ''
  end

  def category_for(category)
    case category.downcase.to_sym
    when :trim
      "<small class=\"label label-primary\">#{category}</small>".html_safe
    when :buds
      "<small class=\"label label-info\">#{category}</small>".html_safe
    end
  rescue
    ''
  end
end
