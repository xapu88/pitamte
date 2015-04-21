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

  def self.find_or_create_for_facebook(uid, data, token)
    binding = User.find_binding("facebook", uid)

    if binding
      user = binding.user
      binding.refresh_token(token)
      return user
    elsif user = User.find_by_email(data["email"])
      user.bind_service("facebook", uid, token)
      return user
    else
      user = User.new_from_provider_data("facebook", uid, data, token)
      if user.save(:validate => false)
        user.bind_service("facebook", uid, token)
        return user
      else
        return nil
      end
    end

  end

  def new_from_provider_data(provider, uid, data, token)
    user = User.new
    user.email = data["email"]
    user.name = data["nickname"] ? data ["nickname"] : data["name"]      
    user.password = Devise.friendly_token[0,20]
    return user
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
