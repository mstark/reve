require 'test_helper'

class AllianceTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_alliances_clean
    Reve::API.alliances_url = XML_BASE + 'alliances.xml'
    alliances = nil
    assert_nothing_raised do
      alliances = @api.alliances
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 3, alliances.size
    corpsize = 0
    alliances.each do |alliance|
      assert_instance_of Reve::Classes::Alliance, alliance
      assert_not_equal 0, alliance.member_corporations
      assert_not_nil alliance.name
      assert_not_nil alliance.id
      assert_not_nil alliance.short_name
      assert_not_nil alliance.member_count
      assert_not_nil alliance.executor_corp_id
      corpsize += alliance.member_corporations.size
    end
    assert_equal 150, corpsize
  end

end
