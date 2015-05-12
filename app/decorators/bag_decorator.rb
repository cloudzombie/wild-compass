class BagDecorator < ApplicationDecorator
  
  include Wild::Compass::Decorator::Story

  decorates :bag
  
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

  def location
    h.link_to_unless model.location.nil?, model.location, model.location, class: "btn-sm btn-flat btn-warning"
  end

  def delta
    h.weight_for model.delta
  end

  def previous_delta
    h.weight_for model.delta_old
  end

  def lot
    h.link_to_unless model.lot.nil?, model.lot, model.lot, class: "btn-sm btn-flat btn-info"
  end

  def menu
    h.content_tag :ul, role: 'menu', class: 'dropdown-menu pull-right' do
      [ h.content_tag(:li, print_label),
        h.content_tag(:li, send_to_lab),
        h.content_tag(:li, reweight),
        h.content_tag(:li, recall),
        h.content_tag(:li, quarantine),
        h.content_tag(:li, edit) ].join.html_safe
    end
  end

  private

    def print_label
      link_to_if_can? :print_label, "#{h.fa_icon 'tag' } Print Label".html_safe, h.label_bag_path(model), class: "text-blue"
    end

    def send_to_lab
      link_to_if_can? :send_to_lab, "#{h.fa_icon 'flask' } Send To Lab".html_safe, h.send_to_lab_bag_path(model), class: "text-yellow", data: { confirm: "WARNING : SENDING BAG TO LAB\r\nAre you sure?" }
    end

    def reweight
      link_to_if_can? :reweight, "#{h.fa_icon 'tags' } Reweight".html_safe, h.reweight_bag_path(model), class: "text-green", data: { href: h.reweight_bag_path(model) }
    end

    def recall
      link_to_if_can? :recall, "#{h.fa_icon 'square' } Recall".html_safe, h.recall_bag_path(model), class: "text-yellow", data: { confirm: "WARNING : RECALLING BAG\r\nAre you sure?" }
    end

    def quarantine
      link_to_if_can? :quarantine, "#{h.fa_icon 'circle' } Quarantine".html_safe, h.quarantine_bag_path(model), class: "text-yellow", data: { confirm: "WARNING : QUARANTINING BAG\r\nAre you sure?" }
    end

    def edit
      link_to_if_can? :edit, "#{h.fa_icon 'tags' } Edit".html_safe, h.edit_bag_path(model), class: "text-red"
    end

end
