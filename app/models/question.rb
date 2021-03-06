class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :answers
  default_scope -> { order(created_at: :desc) }
  validates :category_id, presence: true
  validates :title, presence: true, length: { minimum: 5, maximum: 80 }
  validates :content, length: { maximum: 300 }

  #has_reputation :votes, source: :user, aggregated_by: :sum
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    title_changed?
  end

  def owner?(user)
  	self.user_id == user.id
  end

  def answered?
    !self.answers.empty?
  end
end
