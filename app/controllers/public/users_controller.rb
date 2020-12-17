class Public::UsersController < ApplicationController
  before_action :guest_user, only: [:edit, :update, :quit, :out]

  def show
    @user = User.find(params[:id])
    @genres = Genre.all
  end

  def index
    @users = User.all
    @genres = Genre.all
  end

  def edit
    @user = current_user
    if @user.id != current_user.id
      redirect_to user_path(@user)
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "登録情報を変更しました"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def quit
  end

  def out
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:info] = "「SHOGI-PARK」をご利用ありがとうございました"
    redirect_to root_path
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
