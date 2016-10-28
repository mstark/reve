require 'test_helper'

class StarbaseDetailsTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_starbase_details
    Reve::API.starbasedetail_url = XML_BASE + 'starbase_fuel.xml'
    detail = nil
    assert_nothing_raised do
      detail = @api.starbase_details(:starbaseid => 1,:characterid => 2)
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until

    assert_not_nil detail.state
    assert_kind_of Time, detail.state_timestamp
    assert_kind_of Time, detail.online_timestamp
    assert_instance_of Reve::Classes::StarbaseGeneralSettings, detail.general_settings
    assert_instance_of Reve::Classes::StarbaseCombatSettings, detail.combat_settings
    assert_equal 9, detail.fuel.size

    assert_not_nil detail.general_settings.usage_flags
    assert [TrueClass, FalseClass].include?(detail.general_settings.allow_corporation_members.class)
    assert [TrueClass, FalseClass].include?(detail.general_settings.allow_alliance_members.class)
    assert [TrueClass, FalseClass].include?(detail.general_settings.claim_sovereignty.class)

    assert_not_nil detail.combat_settings.on_standings_drop
    assert_not_nil detail.combat_settings.on_status_drop
    assert_not_nil detail.combat_settings.on_aggression
    assert_not_nil detail.combat_settings.on_corporation_war

    detail.fuel.each do |fuel|
      assert_not_nil fuel.type_id
      assert_not_nil fuel.quantity
    end
  end

end
