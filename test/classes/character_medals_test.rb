require 'test_helper'

class CharacterMedalsTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_character_medals
    Reve::API.character_medals_url = XML_BASE + 'char_medals.xml'
    obj = nil

    assert_nothing_raised do
      obj = @api.character_medals
    end
    assert_kind_of(Reve::Classes::CharacterMedals, obj)
    assert_equal(1, obj.current_corporation.size)
    assert obj.other_corporation.empty?
    obj.current_corporation.each do |medal|
      assert_kind_of(Reve::Classes::CharacterMedal, medal)
      assert_kind_of(Numeric, medal.id)
      assert_kind_of(Time, medal.issued_at)
      assert_kind_of(String, medal.reason)
      assert_kind_of(Numeric, medal.issuer_id)
      assert_kind_of(String, medal.status)
      assert medal.is_public?
      assert ! medal.is_private?
    end
  end


end
