class Message
	include ActiveAttr::Model
  
  attribute :name
  attribute :email
  attribute :subject
  attribute :content
  
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :subject
  validates_length_of :content, :maximum => 500
end