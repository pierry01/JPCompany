class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  
  layout :layout_by_resoure
  
  protected
  
  def layout_by_resoure
    if devise_controller? && resource_name == :admin
      'backoffice_devise'
    else
      'application'
    end
  end
  
  def user_not_authorized
    flash[:alert] = 'Você não está autorizado para executar essa ação.'
    redirect_to(request.referrer || root_path)
  end
end
