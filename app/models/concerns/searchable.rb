module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(search)
      return all if search.nil? || search.empty?
      find_by_id
    rescue
      all
    end

    private

      def find_by_name
        query = where('lower(name) LIKE ?', "%#{search}%".downcase)
        
        if query.empty?
          none
        else
          query
        end
      end

      def find_by_id
        query = where(id: search.split(',').map(&:strip))
      
        if query.empty?
          find_by_hash
        else
          query
        end
      end

      def find_by_hash
        query = where(datamatrix_hash: search)
      
        if query.empty?
          find_by_name
        else
          query
        end
      end

  end
end