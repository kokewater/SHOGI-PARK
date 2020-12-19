class Public::AnswersController < ApplicationController
  before_action :guest_user, only: [:create, :destroy]
  before_action :ensure_correct_user, only: [:destroy]

  def create
    @question = Question.find(params[:question_id])
    answer = current_user.answers.new(answer_params)
    answer.question_id = @question.id
    answer.save
  end

  def update
    Answer.find_by(id: params[:id], question_id: params[:question_id]).update(best_answer_params)
    @question = Question.find(params[:question_id])
    redirect_to request.referer
  end

  def destroy
    Answer.find_by(id: params[:id], question_id: params[:question_id]).destroy
    @question = Question.find(params[:question_id])
  end

  private
  def answer_params
    params.require(:answer).permit(:answer)
  end

  def best_answer_params
    params.require(:answer).permit(:is_best_answered)
  end

  def ensure_correct_user
    answer = Answer.find(params[:id])
    if current_user.id != answer.user.id
      redirect_to questions_path
    end
  end
end