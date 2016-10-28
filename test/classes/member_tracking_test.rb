require 'test_helper'

class MemberTrackingTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_member_tracking_clean
    Reve::API.member_tracking_url = XML_BASE + 'member_tracking.xml'
    members = nil
    assert_nothing_raised do
      members = @api.member_tracking(:characterid => 1)
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 2, members.size
    members.each do |member|
      assert_not_nil member.character_id
      assert_not_nil member.character_name
      assert_not_nil member.start_time
      assert_not_nil member.base_id
      assert_not_nil member.base
      assert_not_nil member.title
      assert_not_nil member.logon_time
      assert_not_nil member.logoff_time
      assert_not_nil member.location_id
      assert_not_nil member.location
      assert_not_nil member.ship_type_id
      assert_not_nil member.ship_type
      assert_not_nil member.roles
      assert_not_nil member.grantable_roles
    end
  end

end
