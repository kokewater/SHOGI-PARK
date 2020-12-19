class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def guest_user
    @user = User.find_by(email: 'guest@example.com')
    if @user == current_user
      flash[:warning] = '※ゲストユーザーは編集・投稿が出来ません'
      redirect_to request.referer
    end
  end

  private

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_top_path
    when User
      questions_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    else
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end
