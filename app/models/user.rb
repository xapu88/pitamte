class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :questions
  has_many :answers
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source

  validates :username, length: { maximum: 20 }

  def voted_up?(answer)
  	evals = evaluations.where(target_type: answer.class, target_id: answer.id)
  	if !evals.empty?
  		return evals.first.value == 1.0
  	else
  		return false
  	end
  end

  def voted_down?(answer)
  	evals = evaluations.where(target_type: answer.class, target_id: answer.id)
  	if !evals.empty?
  		return evals.first.value == -1.0
  	else
  		return false
  	end
  end

  def self.find_or_create_for_facebook(response)
    data = response['extra']['user_hash']
    if user = User.find_by_facebook_id(data["id"])
      user
    else # Create a user with a stub password.
      user = User.new(:email => "facebook+#{data["id"]}@pitamte.com", :password => Devise.friendly_token[0,20])
      user.facebook_id = data["id"]
      user.confirm!
      user
    end
  end

  def display_name
    if facebook_id
      "FB korisnik: #{facebook_id})"
    else
      email
    end
  end

  def to_s
    "#{display_name}"
  end
end
