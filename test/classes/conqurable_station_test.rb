require 'test_helper'

class ConqurableStationTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_conqurable_station
    Reve::API.conqurable_outposts_url = XML_BASE + 'conqurable_stations.xml'
    stations = nil
    assert_nothing_raised do
      stations = @api.conqurable_stations
    end

    assert_equal 3, stations.size
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until

    stations.each do |station|
      assert_not_nil station.id
      assert_not_nil station.name
      assert_not_nil station.type_id
      assert_not_nil station.system_id
      assert_not_nil station.corporation_id
      assert_not_nil station.corporation_name
      assert_not_nil station.system_id
    end
  end

end