class Public::HomesController < ApplicationController
  def top
    @questions = Question.last(4)
  end

  def about
  end
end
