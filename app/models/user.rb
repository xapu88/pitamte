class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]

  has_many :questions
  has_many :answers
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source

  validates :username, length: { maximum: 30 }

  mount_uploader :avatar, AvatarUploader

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

  def self.from_omniauth(auth)
    where(provider: auth.provider, facebook_id: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.facebook_id = auth.uid      
      user.username = auth.extra.raw_info.username
      user.username = auth.extra.raw_info.name
      user.avatar = auth.info.image
      if auth.provider == "twitter"
        user.email = "twitter.#{auth.uid}@pitamte.com"
      else
        user.email = auth.info.email
      end
      user.password = Devise.friendly_token[0,20]
    end
  end

  def display_name
    if facebook_id
      "#{username}"
    else
      email
    end
  end

  def to_s
    "#{display_name}"
  end
end
