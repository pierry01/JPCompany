class ApplicationController < ActionController::Base
  # gem devise
  before_filter :store_current_location, unless: :devise_controller?
  skip_before_action :verify_authenticity_token
  
  # gem pundit
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  
  layout :layout_by_resoure
  
  private
  
  def layout_by_resoure
    if devise_controller? && resource_name == :admin
      'backoffice_devise'
    elsif devise_controller? && resource_name == :user
      'site_devise'
    else
      'application'
    end
  end
  
  def user_not_authorized
    flash[:alert] = 'Você não está autorizado para executar essa ação.'
    redirect_to(request.referrer || root_path)
  end
  
  def store_current_location
    store_location_for(:user, request.url)
  end
end
