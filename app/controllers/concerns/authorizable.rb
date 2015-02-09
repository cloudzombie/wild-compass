module Authorizable
  extend ActiveSupport::Concern
  
  included do
    before_action :authorized?
  end

  private

    def authorized?
      authorize! action_name.to_sym, controller_name.classify.constantize
    end

end