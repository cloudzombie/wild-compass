class ContainerDecorator < ApplicationDecorator

  include Wild::Compass::Decorator::Story

  decorates :container

  delegate_all

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
