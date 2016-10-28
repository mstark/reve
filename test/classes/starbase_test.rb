require 'test_helper'

class StarbaseTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_starbases
    Reve::API.starbases_url = XML_BASE + 'starbases.xml'
    bases = nil
    assert_nothing_raised do
      bases = @api.starbases(:characterid => 1)
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 4, bases.size
    bases.each do |starbase|
      assert_instance_of Reve::Classes::Starbase, starbase
      assert_not_nil starbase.type_id
      assert_not_nil starbase.id
      assert_not_nil starbase.system_id
      assert_not_nil starbase.moon_id
      assert_not_nil starbase.state
      assert_not_nil starbase.state_timestamp
      assert_not_nil starbase.online_timestamp
    end
  end


end
