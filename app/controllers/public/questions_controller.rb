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
    @questions = Question.where(genre_id: params[:genre_id])
    @genres = Genre.all
    @genre = Genre.find(params[:genre_id])
  end

  def show
    @question = Question.find(params[:id])
    @genres = Genre.all
    @answer = Answer.new
  end

  def edit
    @question = Question.find(params[:id])
    if @question.user_id != current_user.id
      redirect_to questions_path
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to question_path(@question), notice: "編集しました"
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  def search
    @genres = Genre.all
    @questions = Question.sort(params[:keyword])
  end

  private
    def question_params
      params.require(:question).permit(:genre_id, :title, :body, :image)
    end

end
