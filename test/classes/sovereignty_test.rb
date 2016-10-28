require 'test_helper'

class SovereigntyTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_sovereignty
    Reve::API.sovereignty_url = XML_BASE + 'sovereignty.xml'
    sovereignties = nil
    assert_nothing_raised do
      sovereignties = @api.sovereignty
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 10, sovereignties.size
    sovereignties[0..4].each do |sovereignty|
      assert_instance_of Reve::Classes::Sovereignty, sovereignty
      assert_not_nil sovereignty.system_id
      assert_not_nil sovereignty.system_name
      assert_not_nil sovereignty.faction_id
      assert_nil     sovereignty.alliance_id
    end
    sovereignties[5..8].each do |sovereignty|
      assert_instance_of Reve::Classes::Sovereignty, sovereignty
      assert_not_nil sovereignty.system_id
      assert_not_nil sovereignty.system_name
      assert_not_nil sovereignty.alliance_id
      assert_not_nil sovereignty.corporation_id
      assert_nil     sovereignty.faction_id
    end
    assert_nil sovereignties[-1].alliance_id
    assert_nil sovereignties[-1].corporation_id
    assert_nil sovereignties[-1].faction_id
  end

end
