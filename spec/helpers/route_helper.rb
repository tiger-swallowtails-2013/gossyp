
module RouteHelper
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end
end
