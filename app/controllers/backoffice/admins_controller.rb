class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: [:edit, :update, :destroy]

  def index
    @admins = Admin.all.order(:email)
    # @admins = Admin.with_restricted_access
  end
  
  def new
    @admin = Admin.new
  end
  
  def create
    @admin = Admin.new(params_admin)
    if @admin.save
      redirect_to backoffice_admins_path, notice: "Administrador #{@admin.email} criada!"
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @admin.update(params_admin)
      redirect_to backoffice_admins_path, notice: "Administrador #{@admin.email} alterada!"
    else
      render :edit
    end
  end
  
  def destroy
    admin_email = @admin.email
    
    if @admin.destroy
      redirect_to backoffice_admins_path, notice: "Administrador #{admin_email} excluído!"
    else
      render :index
    end
  end
  
  private
  
  def set_admin
    @admin = Admin.find(params[:id])
  end
  
  def params_admin
    passwd = params[:admin][:password]
    passwd_confirmation = params[:admin][:password_confirmation]
    params[:admin].except!(:password, :password_confirmation) if passwd.blank? && passwd_confirmation.blank?
    
    params.require(:admin).permit(:name, :role, :email, :password, :password_confirmation)
  end
end
