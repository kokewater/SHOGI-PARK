class Public::LikesController < ApplicationController
  before_action :guest_user, only: [:create, :destroy]

  def create
    question = Question.find(params[:question_id])
    like = current_user.likes.new(question_id: question.id)
    like.save
    redirect_to request.referer
  end

  def destroy
    question = Question.find(params[:question_id])
    like = current_user.likes.find_by(question_id: question.id)
    like.destroy
    redirect_to request.referer
  end
end
