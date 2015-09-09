class RootController < ApplicationController

  def index
  end

  def redirect
    if user_signed_in?
      respond_to do |format|
        format.html
      end

    else
      redirect_to new_user_session_path
    end
  end

end
