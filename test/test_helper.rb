require 'simplecov'
SimpleCov.start 'test_frameworks'

require 'test/unit'
require 'fileutils' # for saving downloaded XML
$LOAD_PATH << './lib'
require 'reve'
require 'pry'

# xml api responses
XML_BASE = File.join(File.dirname(__FILE__), 'xml/')
SAVE_PATH = File.join(File.dirname(__FILE__), 'downloads')

def get_api(userid = nil, apikey = nil, charid = nil)
  api = Reve::API.new(userid, apikey, charid)
  api.save_path = nil
  api
end
