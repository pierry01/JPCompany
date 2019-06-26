class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  
  def new
    build_resource({})
    resource.build_profile_user
    respond_with self.resource
  end
  
  private
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:email, :password, :password_confirmation,
        profile_user_attributes: [:first_name, :second_name]
      ]
    )
  end
end
