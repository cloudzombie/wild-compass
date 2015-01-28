class DashboardController < ApplicationController

  before_action :authorized?

  def home

  end

  private

    def authorized?
      authorize! action_name.to_sym, 'Dashboard'
    end

end
