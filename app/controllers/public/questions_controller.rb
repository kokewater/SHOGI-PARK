class Public::QuestionsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to question_path(@question), notice: "投稿しました"
    else
      render :new
    end
  end
  
  def index
    @questions = Question.all.includes(:user)
    @genres = Genre.all
  end
  
  def sort
  end
  
  def show
    @question = Question.find(params[:id])
    @genres = Genre.all
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  def search
  end
  
  private
    def question_params
      params.require(:question).permit(:genre_id, :title, :body, :image)
    end
  
end
