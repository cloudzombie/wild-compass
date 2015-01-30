module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(search)
      return all if search.nil? || search.empty?
      query = find_by_hash(search)
      if query.empty?
        query = find_by_id(search)
        if query.empty?
          query = find_by_name(search)
          if query.empty?
            none
          else
            query
          end
        else
          query
        end
      else
        query
      end
    end

    private

      def find_by_name(search)
        where('lower(name) LIKE ?', "%#{search}%".downcase)
      end

      def find_by_id(search)
        query = where(id: search.split(',').map(&:strip))
      end

      def find_by_hash(search)
        if columns.include? (:datamatrix_hash)
          query = where(datamatrix_hash: search)
        else
          none
        end
      end

  end
end