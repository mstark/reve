require 'test_helper'

class KillTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  # no need to test corporate cos they're the same.
  # TODO: Test with nested losses
  def test_kills_clean
    kills_cleanly(:personal_kills,File.join(XML_BASE,'kills.xml'))
  end

  def test_corporate_kills_clean
    kills_cleanly(:corporate_kills,File.join(XML_BASE,'kills.xml'))
  end

  # no need to test corporate cos they're the same.
  # TODO: Test with nested losses
  def kills_cleanly(meth = :personal_kills, url = File.join(XML_BASE,'kills.xml'))
    kills = nil
    assert_nothing_raised do
      kills = @api.send(meth,{:url =>url})
    end
    assert_equal 25, kills.size
    assert_equal 25, kills.collect { |k| k.victim.name }.compact.length # i should have 10 good victim names to match with 10 kills

    # Process the Kills here to get the number of "Contained Losses" - KillLoss that are contained within another
    # KillLoss (like a Giant Secure Container); there should only be one contained loss and should be
    # 64 losses (including the contained_losses)
    losses = kills.collect { |k| k.losses }.flatten
    assert_equal 292, losses.size
    contained_losses = losses.collect { |loss| loss.contained_losses  }.flatten
    assert_equal 0, contained_losses.size

    attacker_names = kills.collect { |k| k.attackers.collect { |a| a.name } }.flatten
    assert_equal 98, attacker_names.size # total of 25 attackers (24 players + 1 NPC)
    assert_equal 2, attacker_names.grep(nil).size # npc exists once
    assert_equal 96, attacker_names.compact.length # 24 player attackers

    assert_kind_of Integer, kills.first.victim.faction_id
    assert_kind_of String, kills.first.victim.faction_name

    assert_kind_of String, kills.first.attackers.first.faction_name

    kills.each do |kill|
      assert_kind_of Integer, kill.id
      assert_kind_of Integer, kill.system_id

      assert_kind_of Time, kill.created_at
      assert_nil kill.moon_id # the ones in the kills.xml are all nil
      kill.losses.each do |loss|
        assert_not_nil(loss.type_id)
        assert_not_nil(loss.flag)
        assert_not_nil(loss.quantity_dropped)
        assert_not_nil(loss.quantity_destroyed)
        loss.contained_losses.each do |closs|
          assert_not_nil(closs.type_id)
          assert_not_nil(closs.flag)
          assert_not_nil(closs.quantity_dropped)
          assert_not_nil(closs.quantity_destroyed)
        end
      end
    end
  end

end
