require 'test_helper'

class CorporateMemberMedalTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_corporate_member_medals
    Reve::API.corp_member_medals_url = XML_BASE + 'corp_member_medals.xml'
    medals = nil
    assert_nothing_raised do
      medals = @api.corporate_member_medals
    end
    assert_equal(9, medals.size)
    medals.each do |medal|
      assert_kind_of(Reve::Classes::CorporateMemberMedal, medal)
      assert_kind_of(Numeric, medal.id)
      assert_kind_of(Time, medal.issued_at)
      assert_kind_of(Numeric, medal.character_id)
      assert_kind_of(String, medal.reason)
      assert_kind_of(Numeric, medal.issuer_id)
      assert_kind_of(String, medal.status)
      assert medal.is_public?
      assert ! medal.is_private?
    end
  end

end
