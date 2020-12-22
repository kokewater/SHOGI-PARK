class Admin::AnswersController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    Answer.find_by(id: params[:id], question_id: params[:question_id]).destroy
    @question = Question.find(params[:question_id])
    redirect_to request.referer
  end
end
