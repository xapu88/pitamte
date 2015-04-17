class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:my_questions, :my_answers]

  def home
  	@categories = Category.all
  	@questions = Question.all
  end

  def my_questions
    @questions = Question.where(user_id: current_user.id)
  end

  def my_answers
    @answers = Answer.where(user_id: current_user.id)
  end

  def contact
  end

  def about
  end

  def agreements
  end
end
