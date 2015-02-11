module Sortable
  extend ActiveSupport::Concern

  module ClassMethods
    def sort(attribute, direction)
      return order(attribute.to_sym => direction.to_sym) if column_names.include?(attribute.to_s)
      return by_delegated_attribute(attribute, direction) if respond_to?(attribute.to_sym)
      all
    end

    private

      def by_delegated_attribute(attribute, direction)
        joins(:attribute).merge(attribute.classify.constantize.order(attribute.to_sym => direction.to_sym))
      end
  end

end