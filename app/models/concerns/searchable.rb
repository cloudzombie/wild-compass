module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(search)
      if search
        queries = []
        search_params = []
        
        columns.each do |column|
          case column.type
          when :integer
            queries << "#{column.name} = ?"
            search_params << "#{search}".to_i
          when :text, :string
            queries << "#{column.name} LIKE ?"
            search_params << "%#{search}%"
          when :decimal
            queries << "#{column.name} = ?"
            search_params << "#{search}".to_d
          when :datetime
            begin
              datetime = DateTime.parse("#{search}")
              queries << "#{column.name} <= ?"
              search_params << datetime.to_s
            rescue
              next
            end
          else
            queries << "#{column.name} = ?"
            search_params << "%#{search}%"
          end
        end
        
        where queries.join(' OR '), *search_params

      else
        all
      end
    end
  end
end