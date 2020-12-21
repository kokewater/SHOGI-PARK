class Admin::HomesController < ApplicationController
  def top
    @users = User.all
    @questions = Question.where(created_at: Time.now.in_time_zone.all_day)
  end
end
