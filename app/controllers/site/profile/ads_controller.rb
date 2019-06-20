class Site::Profile::AdsController < Site::ProfileController
  def index
    @ads = Ad.where(user: current_user)
  end
end
