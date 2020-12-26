class Public::LikesController < ApplicationController
  before_action :guest_user, only: [:create, :destroy]
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    like = current_user.likes.new(question_id: @question.id)
    like.save
  end

  def destroy
    @question = Question.find(params[:question_id])
    like = current_user.likes.find_by(question_id: @question.id)
    like.destroy
  end
end
