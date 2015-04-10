class PlantDecorator < ApplicationDecorator
  
  decorates :plant

  delegate_all

  def menu
    h.content_tag :ul, role: 'menu', class: 'dropdown-menu pull-right' do
      [ h.content_tag(:li, label), h.content_tag(:li, update) ].join.html_safe
    end
  end

  private

    def label
      link_to_if_can? :label, Plant, 'Label', h.label_plant_path(model), class: "text-green"
    end

    def update
      link_to_if_can? :update, Plant, 'Edit', h.edit_plant_path(model), class: "text-yellow"
    end

end
