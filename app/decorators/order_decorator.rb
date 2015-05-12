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
      link_to_if_can? :fulfill, "#{h.fa_icon 'check-square-o' } Fulfill".html_safe, h.fulfill_order_path(model), class: "text-green", data: { href: h.fulfill_order_path(model) }
    end

    def update
      link_to_if_can? :edit, "#{h.fa_icon 'tags' } Edit".html_safe, h.edit_order_path(model), class: "text-red"
    end

end
