class Public::QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :guest_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :destroy]

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      flash[:success] = "質問を投稿しました"
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def index
    @questions = Question.includes(:user).page(params[:page]).reverse_order
    @genres = Genre.all
  end

  def sort
    @questions = Question.includes(:user).where(genre_id: params[:genre_id]).page(params[:page]).reverse_order
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
      flash[:success] = "質問を編集しました"
      redirect_to question_path(@question)
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
    @sort_type = params[:keyword] == nil ? "new" : params[:keyword]
    @questions = Question.sort(params[:keyword])
    @questions = Kaminari.paginate_array(@questions).page(params[:page])
  end

  private

  def question_params
    params.require(:question).permit(:genre_id, :title, :body, :image)
  end

  def ensure_correct_user
    question = Question.find(params[:id])
    if current_user.id != question.user.id
      redirect_to questions_path
    end
  end
end
