class PagesController < ApplicationController
  def home
  	@categories = Category.all
  	@questions = Question.all
    @question = Question.new
  end

  def contact
  end

  def about
  end

  def agreements
  end
end
