module Nameable
  extend ActiveSupport::Concern

  def to_s
    "#{identifier}-#{uid}".upcase
  end

  alias_method :name, :to_s

  private

    def identifier
      self.class
    end

    def uid
      id
    end

end