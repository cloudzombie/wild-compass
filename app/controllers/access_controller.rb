class AccessController < ApplicationController

  helper_method :referer

  def check
    if request.post?
      if supervisor_authenticated?
        current_user.temporary_role = User::Role.manager
        current_user.temporary_role_expires_at = Time.now + 1.hour
        current_user.save
        redirect_to params[:referer], notice: 'Override succesful.'
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

    def referer
      params[:referer]
    end

    def supervisor
      User.find_by(email: params[:supervisor_email])
    end

    def supervisor_authenticated?
      !!supervisor.try(:valid_password?, params[:supervisor_password])
    end

end
