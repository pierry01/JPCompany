class ApplicationController < ActionController::Base
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
end
