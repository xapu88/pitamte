class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :content, presence: true, length: { minimum: 3, maximum: 1000 }

  def owner?(user)
  	self.user_id == user.id
  end
end
