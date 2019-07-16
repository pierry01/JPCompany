class Site::AdDetailController < SiteController
  def show
    @categories = Category.order_by_description
    @ad = Ad.friendly.find(params[:id])
  end
end
