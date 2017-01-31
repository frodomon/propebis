class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = exception.message
    redirect_to :back
  end
  before_filter :require_login

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username, :email,:password, :password_confirmation, roles: [] ])
  end

  private
  def require_login
    unless current_user
      redirect_to unauthenticated_root_path
    end
  end
end
