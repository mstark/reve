require 'simplecov'
SimpleCov.start 'test_frameworks'

require 'test/unit'
require 'fileutils' # for saving downloaded XML
$LOAD_PATH << './lib'
require 'reve'
require 'pry'
