class LotDecorator < ApplicationDecorator

  include Wild::Compass::Decorator::Story

  decorates :lot

  delegate_all

  def menu
    h.content_tag :ul, role: 'menu', class: 'dropdown-menu pull-right' do
      [ h.content_tag(:li, update),
        h.content_tag(:li, recall),
        h.content_tag(:li, quarantine),
        h.content_tag(:li, release),
        h.content_tag(:li, relot) ].join.html_safe
    end
  end

  private

    def update
      link_to_if_can? :update, 'Edit', h.edit_lot_path(model), class: "text-yellow"
    end

    def recall
      if model.recalled?
        link_to_if_can? :unrecall, "#{h.fa_icon 'tag' } Unrecall".html_safe, h.unrecall_lot_path(model), class: 'red-link', data: { confirm: "WARNING : UNRECALLING LOT\r\nAre you sure?" }
      else
        link_to_if_can? :recall, "#{h.fa_icon 'tag' } Recall".html_safe, h.recall_lot_path(model), class: 'red-link', data: { confirm: "WARNING : RECALLING LOT\r\nAre you sure?" }
      end
    end

    def quarantine
      if model.quarantined?
        link_to_if_can? :unquarantine, "#{h.fa_icon 'tag' } Unquarantine".html_safe, h.unquarantine_lot_path(model), class: 'red-link', data: { confirm: "WARNING : UNQUARANTINING LOT\r\nAre you sure?" }
      else
        link_to_if_can? :quarantine, "#{h.fa_icon 'tag' } Quarantine".html_safe, h.quarantine_lot_path(model), class: 'red-link', data: { confirm: "WARNING : QUARANTINING LOT\r\nAre you sure?" }
      end
    end

    def release
      if model.released?
        link_to_if_can? :release, "#{h.fa_icon 'tag' } Unrelease".html_safe, h.unrelease_lot_path(model), class: 'red-link', data: { confirm: "WARNING : UNRELEASING LOT\r\nAre you sure?" }
      else
        link_to_if_can? :release, "#{h.fa_icon 'tag' } Release".html_safe, h.release_lot_path(model), class: 'red-link', data: { confirm: "WARNING : RELEASING LOT\r\nAre you sure?" }
      end
    end

    def relot
      link_to_if_can? :relot, "#{h.fa_icon 'tag' } Relot".html_safe, h.relot_lot_path(model), class: 'red-link', data: { confirm: "WARNING : RELOTTING\r\nAre you sure?" }
    end

end
