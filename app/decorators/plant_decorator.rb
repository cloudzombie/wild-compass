class PlantDecorator < ApplicationDecorator
  
  include Wild::Compass::Decorator::Story

  decorates :plant

  delegate_all

  def name
    h.link_to model, model, class: "btn-sm btn-flat btn-success"
  end

  def strain
    h.strain_for model.strain
  end

  def format
    h.format_for model.format
  end

  def menu
    h.content_tag :ul, role: 'menu', class: 'dropdown-menu pull-right' do
      [ h.content_tag(:li, label), h.content_tag(:li, update) ].join.html_safe
    end
  end

  private

    def label
      link_to_if_can? :print_label, "#{h.fa_icon 'tag' } Print Label".html_safe, h.label_plant_path(model), class: "text-blue"
    end

    def update
      link_to_if_can? :edit, "#{h.fa_icon 'tags' } Edit".html_safe, h.edit_bag_path(model), class: "text-red"
    end

end
