class Public::UsersController < ApplicationController
  before_action :guest_user, only: [:edit, :update, :quit, :out]
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @genres = Genre.all
    @questions = @user.questions.page(params[:page]).per(6).reverse_order
  end

  def index
    @users = User.page(params[:page]).per(12)
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
    flash[:info] = "「SHOGI-PARK」をご利用いただきありがとうございました"
    redirect_to root_path
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings.page(params[:page]).per(12)
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers.page(params[:page]).per(12)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
