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
      precision: 0
    )
  rescue
    '0'
  end

  def percent_for(decimal, precision = 1)
    number_with_precision(decimal, precision: precision)
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
    elsif weight == 'ERROR'
      'ERROR'
    else
      "#{number_with_precision weight.to_d, precision: 2 }#{g}"
    end
  rescue
    ''
  end

  def date_for(datetime)
    datetime.strftime("%m/%d/%Y %H:%M")
  rescue
    ''
  end

  def strain_for(strain)
    "<small class=\"label label-default\">#{strain}</small> ".html_safe
  rescue
    ''
  end

  def format_for(format)
    case format.to_s.upcase
    when '60 G', '60G'
      "<small class=\"badge alert-info\">#{format}</small>".html_safe
    when '45 G', '45G'
      "<small class=\"badge alert-warning\">#{format}</small>".html_safe
    when '15 G', '15G'
      "<small class=\"badge alert-primary\">#{format}</small>".html_safe
    else
      "<small class=\"badge\">#{format}</small>".html_safe
    end
  rescue
    ''
  end

  def category_for(category)
    case category.downcase.to_sym
    when :trim
      "<small class=\"label label-primary\">TRIM</small>".html_safe
    when :buds
      "<small class=\"label label-info\">BUDS</small>".html_safe
    when :unprocessed
      "<small class=\"label label-warning\">UNPROCESSED</small>".html_safe
    when :budsonstem
      "<small class=\"label label-success\">BUDS ON STEM</small>".html_safe
    else
      ''
    end
  rescue
    "<small class=\"label label-danger\">ERROR</small>".html_safe
  end

  def ordered_by_id(collection)
    collection.order(id: :asc)
  end

  def to_data_url(image)
    'data:image/png;base64,' << Base64.strict_encode64( image )
  end

  def label_path_for(item)
    case item
    when Bag
      label_bag_path(item)
    when Jar
      label_jar_path(item)
    when Bin
      label_bin_path(item)
    else
      '#'
    end
  end

  def quarantine_for(item)
    if item
      'Yes'
    else
      'No'
    end
  end

  def recall_for(item)
    quarantine_for(item)
  end

  def variance_for(initial, current)
    return percent_for 0.00, 2 if initial - current == 0.0 && initial == 0.0
    variance = (initial - current) / initial
    if variance > 0.01905
      "<span class=\"badge bg-maroon\">#{percent_for variance, 4}</span>".html_safe
    else
      percent_for variance
    end
  end

  def bag_variance(bag)
    if bag.history.history_lines.where(source_id: bag.id, target_id: bag.id)[-2].present? && bag.history.history_lines.where(source_id: bag.id, target_id: bag.id)[-1].present? then
      variance_for bag.history.history_lines.where(source_id: bag.id, target_id: bag.id)[-2].quantity, bag.history.history_lines.where(source_id: bag.id, target_id: bag.id)[-1].quantity
    end
  end

  def sum(collection, attribute)
    total = 0
    collection.each do |item|
      total += item.send(attribute) || 0
    end
    total
  end

  #def monthly_variance_for(item)
  #  variance = item.history.history_lines.where(source == target).current_weight.variance
  #  if variance/current_weight > 0.01905
  #    "<span class=\"badge bg-maroon\">#{percent_for variance, 2}</span>".html_safe
  #  else
  #    percent_for variance, 2
  # end
  #end
end
