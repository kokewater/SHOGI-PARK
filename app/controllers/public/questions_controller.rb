class Public::QuestionsController < ApplicationController
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to question_path(@question), notice: "投稿しました"
    else
      render :new
    end
  end
  
  def index
    @questions = Question.all
    @genres = Genre.all
  end
  
  def sort
  end
  
  def show
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
