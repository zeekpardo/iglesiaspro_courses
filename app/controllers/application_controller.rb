class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
      devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    end
  
    def authorize_admin!
      redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.admin?
    end
end
