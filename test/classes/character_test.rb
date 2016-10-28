require 'test_helper'

class CharacterTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_characters
    Reve::API.characters_url = XML_BASE + 'characters.xml'
    chars = nil
    assert_nothing_raised do
      chars = @api.characters
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 1, chars.size
    chars.each do |char|
      assert_not_nil(char.name)
      assert_not_nil(char.id)
      assert_not_nil(char.corporation_name)
      assert_not_nil(char.corporation_id)
      assert_instance_of Reve::Classes::Character, char
    end
  end

end
