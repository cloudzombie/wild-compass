class OrderDecorator < ApplicationDecorator

  decorates :order

  delegate_all

  def actions
    h.content_tag :div, { role: 'group', class: 'btn-group' } do
      h.content_tag :button, { type: 'button', class: "btn-xs btn-primary dropdown-toggle", :"data-toggle" => 'dropdown', :"data-aria-expanded" => false } do
        h.content_tag "Actions #{h.content_tag :span, class: 'caret'}".html_safe
      end

      h.content_tag :ul, role: 'menu', class: 'dropdown-menu pull-right' do
        h.content_tag :li, fulfill
        h.content_tag :li, update
      end
    end
  end

  private

    def fulfill
      link_to_if_can? :fulfill, model, 'Fulfill', h.fulfill_order_path(model), class: "text-green", data: { href: h.fulfill_order_path(model) }
    end

    def update
      link_to_if_can? :update, Order, 'Edit', model, class: "text-yellow"
    end

    def link_to_if_can?(action, resource, *content)
      h.link_to_if h.can?(action, resource), *content
    end

end
