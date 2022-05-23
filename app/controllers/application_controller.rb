class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:login_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:login_name])
  end
end
