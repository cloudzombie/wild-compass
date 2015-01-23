module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(search)
      if search
        queries = []
        column_names.each do |column|
          queries << "#{column} LIKE ?"
        end
        search_param = "%#{search}%"
        search_params = []
        queries.each do
          search_params << search_param
        end
        where queries.join(' OR '), *search_params
      else
        all
      end
    end
  end
end