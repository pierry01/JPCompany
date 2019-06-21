class Site::Profile::AdsController < Site::ProfileController
  before_action :set_ad, only: [:edit]
  
  def index
    @ads = Ad.includes(:category).to_the(current_user)
  end
  
  def edit
  end
  
  def update
  end
  
  private
  
  def set_ad
    @ad = Ad.find(params[:id])
  end
end
