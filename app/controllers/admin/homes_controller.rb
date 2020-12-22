class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @users = User.all
    @questions = Question.where(created_at: Time.now.in_time_zone.all_day)
    @answers = Answer.where(created_at: Time.now.in_time_zone.all_day)
  end
end
