class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :answers
  default_scope -> { order(created_at: :desc) }
  validates :category_id, presence: true
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :content, length: { maximum: 300 }

  def owner?(user)
  	self.user_id == user.id
  end
end
