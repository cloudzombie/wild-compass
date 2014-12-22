class RootController < ApplicationController
  
  def redirect
    if user_signed_in?
      redirect_to inventory_path
    else
      redirect_to sign_in_path
    end
  end
  
end
