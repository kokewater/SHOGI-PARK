class Public::PostMessagesController < ApplicationController
  
  before_action :guest_user, only: [:create]
  
  def index
    @genres = Genre.all
    @post_messages = PostMessage.all
    @post_message = PostMessage.new
  end

  def create
    @post_message = PostMessage.new(post_message_params)
    @post_message.user_id = current_user.id
    if @post_message.save
      redirect_to request.referer
    else
      @genres = Genre.all
      @post_messages = PostMessage.all
      render :index
    end
  end

  private
  def post_message_params
    params.require(:post_message).permit(:message)
  end
end