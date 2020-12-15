class Admin::HomesController < ApplicationController
  def top
    @users = User.all
    @questions = Question.all
  end
end
