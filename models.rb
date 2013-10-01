class Gossyp < ActiveRecord::Base
  has_many :responses

  validates :title, :presence => true
  validates :body, :presence => true
end

class User < ActiveRecord::Base
  has_many :gossyps
  def self.from_auth_hash(auth_hash)
    user = User.find_or_create_by(twitter_uid: auth_hash[:uid])
    user.update_attributes(full_name: auth_hash[:info][:name])
    user
  end
end

class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :gossyp
end
