class Backoffice::AdsController < BackofficeController
  before_action :set_ad, only: [:destroy, :edit, :update]
  
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
  
  def destroy
    if @ad.destroy
      redirect_to backoffice_ads_path, notice: 'Anúncio excluído!'
    else
      render :index
    end
  end
  
  private
  
  def set_ad
    @ad = Ad.friendly.find(params[:id])
  end
  
  def params_ad
    params.require(:ad).permit( :id, :title, :picture, :finish_date, 
                               :category_id, :price, :description )
  end
end
