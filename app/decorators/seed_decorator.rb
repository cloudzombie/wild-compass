class SeedDecorator < ApplicationDecorator

  include Wild::Compass::Decorator::Story

  decorates :seed

  delegate_all

  def menu
    h.content_tag :ul, role: 'menu', class: 'dropdown-menu pull-right' do
      [ h.content_tag(:li, print_label),
        h.content_tag(:li, reweight),
        h.content_tag(:li, edit) ].join.html_safe
    end
  end

  def initial_weight
    h.weight_for model.initial_weight
  end

  def current_weight
    h.weight_for model.current_weight
  end

  private

    def print_label
      link_to_if_can? :print_label, "#{h.fa_icon 'tag' } Print Label".html_safe, h.label_seed_path(model), class: "text-blue"
    end

    def reweight
      link_to_if_can? :reweight, "#{h.fa_icon 'tags' } Reweight".html_safe, h.reweight_seed_path(model), class: "text-green", data: { href: h.reweight_seed_path(model) }
    end

    def edit
      link_to_if_can? :edit, "#{h.fa_icon 'tags' } Edit".html_safe, h.edit_seed_path(model), class: "text-red"
    end

end
