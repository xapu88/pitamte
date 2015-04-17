class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:my_questions, :my_answers]

  def home
  	@categories = Category.all
  	@questions = Question.page(params[:page])
  end

  def my_questions
    @questions = Question.where(user_id: current_user.id).page(params[:page])
  end

  def my_answers
    @answers = Answer.where(user_id: current_user.id).page(params[:page])
  end

  def contact
  end

  def about
  end

  def agreements
  end
end
