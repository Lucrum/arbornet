class ApplicationController < ActionController::Base
  before_action :configure_permitted_parmeters, if: :devise_controller?

  protected

  def configure_permitted_parmeters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
