class Category < ActiveRecord::Base
	has_many :questions
	validates :title, presence: true, length: { minimum: 3, maximum: 30 }

	extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    title_changed?
  end
end
