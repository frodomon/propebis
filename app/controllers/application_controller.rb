class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_sign_in_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = exception.message
    redirect_to :back
  end

  protected

  def configure_sign_in_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username, :email,:password, :password_confirmation, roles: [] ])
  end
end
