class Backoffice::UsersController < BackofficeController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.order(:email).page(params[:page]).per(10)
  end
  
  def edit
  end
  
  def update
    if @user.update(params_user)
      redirect_to backoffice_users_index_path, notice: "Usuário #{@user.email} alterado!"
    else
      render :edit
    end
  end
  
  def destroy
    if @user.destroy
      redirect_to backoffice_users_index_path, notice: "Usuário #{@user.email} excluído!"
    else
      render :index
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def params_user
    params[:user].except!(:password, :password_confirmation) if password_blank?
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  
  def password_blank?
    params[:user][:password].blank? &&
    params[:user][:password_confirmation].blank?
  end
end
