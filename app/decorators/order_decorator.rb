class OrderDecorator < ApplicationDecorator

  decorates :order

  delegate_all

  def menu
    h.content_tag :ul, role: 'menu', class: 'dropdown-menu pull-right' do
      [ h.content_tag(:li, fulfill), h.content_tag(:li, update) ].join.html_safe
    end
  end

  private

    def fulfill
      link_to_if_can? :fulfill, model, 'Fulfill', h.fulfill_order_path(model), class: "text-green", data: { href: h.fulfill_order_path(model) }
    end

    def update
      link_to_if_can? :update, Order, 'Edit', h.edit_order_path(model), class: "text-yellow"
    end

end
