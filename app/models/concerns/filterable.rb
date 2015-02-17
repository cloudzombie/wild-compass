module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(args)
      return all if args.nil? || args.empty?
      all
    end
  end

end