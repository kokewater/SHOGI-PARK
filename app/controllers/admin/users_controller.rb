class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "登録情報を変更しました"
      redirect_to admin_users_path
    else
      render :edit
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :is_deleted)
  end
end
