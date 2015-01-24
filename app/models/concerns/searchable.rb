module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(search)
      return all if search.nil? || search.empty?
      query = where(id: search.split(',').map(&:strip)) #.map(&:to_i)
      
      if query.empty?
        query = where('lower(name) LIKE ?', "%#{search}%".downcase)
        
        if query.empty?
          none
        else
          query
        end

      else
        query
      end
    rescue
      all
    end

  end
end