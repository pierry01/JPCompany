class Backoffice::AdsController < BackofficeController
  before_action :set_ad, only: [:edit, :update]
  
  def index
    @ads = Ad.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def new
    @ad = Ad.new
  end
  
  def create
    @ad = Ad.new(params_ad)
    @ad.admin = current_admin
    
    if @ad.save
      redirect_to backoffice_ads_path, notice: 'Anúncio criado!'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @ad.update(params_ad)
      redirect_to backoffice_ads_path, notice: 'Anúncio atualizado!'
    else
      render :edit
    end
  end
  
  private
  
  def set_ad
    @ad = Ad.find(params[:id])
  end
  
  def params_ad
    params.require(:ad).permit( :id, :title, :picture, :finish_date, 
                               :category_id, :price, :description )
  end
end
