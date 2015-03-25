class AnswerPolicy < ApplicationPolicy
  attr_reader :user, :answer

  def initialize(user, answer)
    @user = user
    @answer = answer
  end

  def update?
    !answer.approved?
  end

  def edit?
    update?
  end

  def destroy?
    !answer.approved?
  end
  class Scope < Scope
    def resolve
      scope
    end
  end
end
