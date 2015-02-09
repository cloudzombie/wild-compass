class AccessController < ApplicationController
  def check
    if request.post?
      if supervisor_authenticated?
        current_user.role = supervisor.role
        redirect_to root_path, notice: 'Override succesful.'
      else
        redirect_to root_path, notice: 'Override unsuccesful.'
      end
    else
      respond_to do |format|
        format.html
      end
    end
  end

  private

    def supervisor
      User.find_by(email: params[:supervisor_email])
    end

    def supervisor_authenticated?
      !!supervisor.try(:valid_password?, params[:supervisor_password])
    end

end
