class Site::Profile::MyDataController < Site::ProfileController
  def edit
    @profile_user = ProfileUser.find_or_create_by(user_id: current_user.id)
  end
end
