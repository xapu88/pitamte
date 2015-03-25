class QuestionPolicy < ApplicationPolicy
  attr_reader :user, :question

  def initialize(user, question)
    @user = user
    @question = question
  end

  def update?
    !question.answered? && !question.approved?
  end

  def edit?
    update?
  end

  def destroy?
    !question.answered? && !question.approved?
  end


  class Scope < Scope
    def resolve
      scope
    end
  end

end
