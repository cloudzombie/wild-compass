class ApplicationDecorator < Draper::Decorator

  def self.collection_decorator_class                                              
    PaginatingDecorator                                                            
  end

  def actions
    h.content_tag :div, { role: 'group', class: 'btn-group' } do
      [ menu_button, menu ].join.html_safe
    end
  end

  def link_to_if_can?(action, *content)
    h.link_to_if h.can?(action, model), *content
  end

  private

    def menu_button
      h.content_tag :button, { type: 'button', class: "btn-xs btn-primary dropdown-toggle", data: { toggle: 'dropdown', aria: { expanded: false }}} do
        [ "Actions ", h.content_tag(:span, nil, class: 'caret') ].join.html_safe
      end
    end
  
end