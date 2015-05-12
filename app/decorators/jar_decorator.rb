class JarDecorator < ApplicationDecorator

  include Wild::Compass::Decorator::Story

  decorates :jar

  delegate_all

  def origin
    h.link_to_unless model.bag.nil?, model.bag, model.bag, class: "btn-sm btn-flat btn-warning"
  end

  def weight
    h.weight_for model.current_weight
  end

  def category
    h.category_for model.category
  end

  def strain
    h.strain_for model.strain
  end

  def menu
    h.content_tag :ul, role: 'menu', class: 'dropdown-menu pull-right' do
      [ h.content_tag(:li, return_jar),
        h.content_tag(:li, send_to_lab),
        h.content_tag(:li, destruction),
        h.content_tag(:li, edit) ].join.html_safe
    end
  end

  private

    def return_jar
      link_to_if_can? :perform_return, "#{h.fa_icon 'reply' } Return".html_safe, h.perform_return_jar_path(model), class: "text-yellow", data: { confirm: "WARNING : RETURNING JAR\r\nAre you sure?" }
    end

    def send_to_lab
      link_to_if_can? :send_to_lab, "#{h.fa_icon 'flask' } Send To Lab".html_safe, h.send_to_lab_jar_path(model), class: "text-yellow", data: { confirm: "WARNING : SENDING JAR TO LAB\r\nAre you sure?" }
    end

    def destruction
      link_to_if_can? :destruction, "#{h.fa_icon 'times' } Destruction".html_safe, h.destruction_jar_path(model), class: "text-yellow", data: { confirm: "WARNING : MARKING JAR FOR DESTRUCTION\r\nAre you sure?" }
    end

    def edit
      link_to_if_can? :edit, "#{h.fa_icon 'tags' } Edit".html_safe, h.edit_jar_path(model), class: "text-red"
    end

end
