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

  def percent_of_weight(object)
    object.current_weight.to_f / object.initial_weight.to_f * 100
  end

end
