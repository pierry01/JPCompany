class Backoffice::CategoriesController < BackofficeController
  before_action :set_category, only: [:destroy, :edit, :update]

  def index
    @categories = Category.all.order(:description)
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = CategoryService.create(params_category)
    
    unless @category.errors.any?
      redirect_to backoffice_categories_path, notice: "Categoria #{@category.description} criada!"
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @category.update(params_category)
      redirect_to backoffice_categories_path, notice: "Categoria #{@category.description} alterada!"
    else
      render :edit
    end
  end
  
  def destroy
    if @category.destroy
      redirect_to backoffice_categories_path, notice: 'Categoria excluída!'
    else
      render :index
    end
  end
  
  private
  
  def set_category
    @category = Category.friendly.find(params[:id])
  end
  
  def params_category
    params.require(:category).permit(:description)
  end
end
