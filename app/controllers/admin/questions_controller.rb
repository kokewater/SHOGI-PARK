class Admin::QuestionsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @questions = Question.includes(:user).page(params[:page]).reverse_order
  end

  def show
    @question = Question.find(params[:id])
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to admin_questions_path
  end
end
