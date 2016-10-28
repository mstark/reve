require 'test_helper'

class CorporateMedalTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_corporate_medals
    Reve::API.corporate_medals_url = XML_BASE + 'corp_medals.xml'
    medals = nil
    assert_nothing_raised do
      medals = @api.corporate_medals
    end
    assert_equal(12, medals.size)
    medals.each do |medal|
      assert_kind_of(Reve::Classes::CorporateMedal, medal)
      assert_kind_of(Numeric, medal.id)
      assert_kind_of(NilClass, medal.issued_at) # Doesn't exist for this class, look at created_at
      assert_kind_of(Time, medal.created_at)
      assert_kind_of(String, medal.description)
      assert_kind_of(Numeric, medal.creator_id)
      assert_kind_of(String, medal.title)
    end
  end

end
