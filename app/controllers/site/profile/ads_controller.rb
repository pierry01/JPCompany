class Site::Profile::AdsController < Site::ProfileController
  before_action :set_ad, only: [:edit, :update]
  
  def index
    @ads = Ad.includes(:category).to_the(current_user)
  end
  
  def edit
  end
  
  def update
    if @ad.update(params_ad)
      redirect_to site_profile_ads_path, notice: 'Anúncio atualizado!'
    else
      render :edit
    end
  end
  
  private
  
  def set_ad
    @ad = Ad.find(params[:id])
  end
  
  def params_ad
    params.require(:ad).permit(:id, :title, :picture, :category_id, :price, :description)
  end
end
