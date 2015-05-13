class OrderDecorator < ApplicationDecorator

  decorates :order

  delegate_all

  def ces_order_id
    h.link_to model, model, class: "btn-sm btn-flat btn-primary"
  end

  def ordered_at
    h.date_for model.ordered_at
  end

  def shipped_at
    h.date_for model.shipped_at
  end

  def description
    h.content_tag :ul, class: "no-padding no-bullets" do
      model.order_lines.collect do |line|
        h.content_tag :li do
          h.content_tag :ul, class: "no-padding no-bullets" do
            line.jars.collect do |jar|
              h.content_tag :li do
                [ h.link_to(jar, jar, class: "btn-sm btn-flat btn-danger"),
                  h.fa_icon("arrow-left", class: "spacer-left spacer-right"),
                  h.link_to_unless(jar.bag.nil?, jar.bag, jar.bag, class: "btn-sm btn-flat btn-warning"),
                  h.fa_icon("arrow-left", class: "spacer-left spacer-right"),
                  h.link_to_unless((jar.bag.nil? || jar.bag.bin.nil?), jar.bag.bin, jar.bag.bin, class: "btn-sm btn-flat btn-warning") ].join.html_safe
              end
            end.join.html_safe
          end
        end
      end.join.html_safe
    end
  end

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
