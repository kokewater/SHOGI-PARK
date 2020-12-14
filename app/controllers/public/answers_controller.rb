class Public::AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    answer = current_user.answers.new(answer_params)
    answer.question_id = @question.id
    answer.save
  end

  def destroy
    Answer.find_by(id: params[:id], question_id: params[:question_id]).destroy
    @question = Question.find(params[:question_id])
  end

  private
  def answer_params
    params.require(:answer).permit(:answer)
  end
end