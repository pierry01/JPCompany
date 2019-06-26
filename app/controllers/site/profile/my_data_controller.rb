class Site::Profile::MyDataController < Site::ProfileController
  before_action :set_profile_user, only: [:edit, :update]
  
  def edit
  end
  
  def update
    if @profile_user.update(params_profile_user)
      redirect_to edit_site_profile_my_datum_path(current_user.id), notice: 'Dados atualizados!'
    else
      render :edit
    end
  end
  
  private
  
  def params_profile_user
    params.require(:profile_user).permit(:id, :first_name, :second_name, :birthdate)
  end
  
  def set_profile_user
    @profile_user = ProfileUser.find_or_create_by(user_id: current_user.id)
  end
end
