class Gossyp < ActiveRecord::Base
  has_many :reactions
  has_many :stars

  validates :title, :presence => true
  validates :body, :presence => true

  def toggle_star! gossyper
    stars.create(user_id: gossyper.id)
  end
end

class User < ActiveRecord::Base
  has_many :gossyps
  has_many :stars

  def self.from_auth_hash(auth_hash)
    user = User.find_or_create_by(twitter_uid: auth_hash[:uid])
    user.update_attributes(full_name: auth_hash[:info][:name])
    user
  end

  def has_starred? gossyp
    stars.where(gossyp_id: gossyp.id).exists?
  end
end

class Reaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :gossyp

  validates :body, :presence => true
end

class Star < ActiveRecord::Base
end
