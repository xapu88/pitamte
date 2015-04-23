class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

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

  def self.from_omniauth(auth)
    #email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
    #email = auth.info.email if email_is_verified
    #user = User.where(:email => email).first if email

    #if user.nil?
    #  user = User.new(
    #    username: auth.extra.raw_info.name,
    #    #username: auth.info.nickname || auth.uid,
    #    email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
    #    password: Devise.friendly_token[0,20]
    #  )
    #  user.save!
    #nd
    where(provider: auth.provider, facebook_id: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.facebook_id = auth.uid
      user.username = auth.extra.raw_info.name
      user.email = auth.info.email
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
