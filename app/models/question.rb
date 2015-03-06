class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  #validates :category_id, presence: true
  validates :title, presence: true, length: { minimum: 3, maximum: 60 }
end
