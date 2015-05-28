class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :content, presence: true, length: { minimum: 2, maximum: 1000 }

  has_reputation :votes, source: :user, aggregated_by: :sum

  def owner?(user)
  	self.user_id == user.id
  end
end
