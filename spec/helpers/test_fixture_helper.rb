require 'securerandom'
module TestFixturesHelper
  def create_gossyper
    User.create({
      twitter_uid: 1234,
      full_name: "Gossyper #{SecureRandom.hex(4)}"
    })
  end

  def create_random_gossyp
    Gossyp.create({
      title: "Gossyp #{SecureRandom.hex(4)}",
      body: "Gossyp Body #{SecureRandom.hex(4)}"
    })
  end
end
