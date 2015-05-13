class BinDecorator < ApplicationDecorator

  decorates :bin

  delegate_all

  def name
    h.link_to model, model, class: "btn-sm btn-flat btn-warning"
  end

  def bags
    content = []

    model.bags.each do |bag|
      content << h.link_to(bag, bag, class: "btn-sm btn-flat btn-warning")
    end

    content.join.html_safe
  end

  def menu
    h.content_tag :ul, role: 'menu', class: 'dropdown-menu pull-right' do
      [ h.content_tag(:li, print_label),
        h.content_tag(:li, edit) ].join.html_safe
    end
  end

  private

    def print_label
      link_to_if_can? :print_label, "#{h.fa_icon 'tag' } Print Label".html_safe, h.label_bin_path(model), class: "text-blue"
    end

    def edit
      link_to_if_can? :edit, "#{h.fa_icon 'tags' } Edit".html_safe, h.edit_bin_path(model), class: "text-red"
    end

end
