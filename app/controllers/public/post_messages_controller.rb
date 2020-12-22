class Public::PostMessagesController < ApplicationController
  before_action :guest_user, only: [:create]
  before_action :authenticate_user!

  def index
    @genres = Genre.all
    @post_messages = PostMessage.includes(:user).page(params[:page]).per(50)
    @post_message = PostMessage.new
  end

  def create
    @post_message = PostMessage.new(post_message_params)
    @post_message.user_id = current_user.id
    if @post_message.save
      redirect_to post_messages_path(page: PostMessage.page(params[:page]).per(50).total_pages)
    else
      @genres = Genre.all
      @post_messages = PostMessage.page(params[:page]).per(50)
      render :index
    end
  end

  private

  def post_message_params
    params.require(:post_message).permit(:message)
  end
end
