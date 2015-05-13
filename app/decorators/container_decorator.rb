class ContainerDecorator < ApplicationDecorator

  include Wild::Compass::Decorator::Story

  decorates :container

  delegate_all

  def strain
    h.strain_for model.strain
  end

  def initial_weight
    h.weight_for model.initial_weight
  end

  def current_weight
    h.weight_for model.current_weight
  end

  def water_loss
    h.weight_for model.water_loss
  end

  def lot
    h.link_to_unless model.lot.nil?, model.lot, model.lot, class: "btn-sm btn-flat btn-info"
  end

  def menu
    h.content_tag :ul, role: 'menu', class: 'dropdown-menu pull-right' do
      [ h.content_tag(:li, edit) ].join.html_safe
    end
  end

  private

    def edit
      link_to_if_can? :edit, "#{h.fa_icon 'tags' } Edit".html_safe, h.edit_container_path(model), class: "text-red"
    end

end
