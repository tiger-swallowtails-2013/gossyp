# rack-flash let's me store data in a hash across requests; as well as cleans
# out the data when it's read. This makes it easy to show a message once and
# only once
require 'rack-flash'
use Rack::Flash
# https://github.com/nakajima/rack-flash#sinatra
