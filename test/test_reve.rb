# -*- coding: utf-8 -*-
require 'test_helper'

class TestReve < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_makes_right_api_empty
    api = get_api
    assert_instance_of Reve::API, api
    assert_equal "", api.userid
    assert_equal "", api.key
    assert_equal "", api.charid
  end
  def test_makes_right_api_1_param
    api = get_api(12345)
    assert_instance_of Reve::API, api
    assert_equal "12345", api.userid
    assert_equal "", api.key
    assert_equal "", api.charid
  end
  def test_makes_right_api_2_param
    api = get_api(12345,54321)
    assert_instance_of Reve::API, api
    assert_equal "12345", api.userid
    assert_equal "54321", api.key
    assert_equal "", api.charid
  end
  def test_makes_right_api_3_param
    api = get_api(12345,54321,'abcde')
    assert_instance_of Reve::API, api
    assert_equal "12345", api.userid
    assert_equal "54321", api.key
    assert_equal "abcde", api.charid
  end

  def test_makes_a_simple_hash
    Reve::API.alliances_url = XML_BASE + 'alliances.xml'
    h = @api.alliances :just_hash => true
    assert_instance_of String, h
    assert_equal "xml/alliances.xml", h
  end

######Test moved to test_reve_failing.rb#########
#  def test_charid_default_works_when_characterid_is_nil
    # this line of code is wrong on so many levels.
#    assert_equal("CharID", Reve::API.new('uid','key','CharID').send(:postfields,{})['characterid'])
#  end

  def test_makes_a_complex_hash
    Reve::API.corporate_wallet_trans_url = XML_BASE + 'market_transactions.xml'
    @api.userid = 999
    @api.key = 'aaa'
    h = @api.corporate_wallet_transactions :accountkey => '1001', :characterid => 123, :beforerefid => 456, :just_hash => true
    assert_instance_of String, h
    assert_equal 'xml/market_transactions.xml:accountkey:1001:beforerefid:456:characterid:123:keyid:999:vcode:aaa',h
  end


  def test_bad_xml
    Reve::API.training_skill_url = XML_BASE + 'badxml.xml'
    skill = @api.skill_in_training
    assert_not_nil @api.last_hash
  end

  def test_saving_xml_works
    @api.save_path = SAVE_PATH
    alliances = @api.alliances :url => File.join(XML_BASE, 'alliances.xml')
    assert File.exists?(File.join(SAVE_PATH, 'alliances', @api.cached_until.to_i.to_s + '.xml'))

    assert_equal(
      Nokogiri::XML(File.open(File.join(XML_BASE, 'alliances.xml'))).to_xml,
      Nokogiri::XML(File.open(File.join(SAVE_PATH, 'alliances', @api.cached_until.to_i.to_s + '.xml'))).to_xml
    )
  end


  def test_saving_xml_when_save_path_is_nil
    assert_nil @api.save_path
    alliances = @api.alliances :url => File.join(XML_BASE,'alliances.xml')
    assert ! File.exists?(File.join(SAVE_PATH,'alliances',@api.cached_until.to_i.to_s + '.xml'))
  end

  # We want to see <url></url> in the saved XML because that's what came from the source
  def test_saving_xml_with_bad_short_tag
    @api.save_path = SAVE_PATH
    @corpsheet = @api.corporation_sheet :url => File.join(XML_BASE, 'corporation_sheet.xml')
    assert_equal "", @corpsheet.url
    assert File.open(File.join(SAVE_PATH, 'corporation_sheet', @api.cached_until.to_i.to_s + '.xml')).read.include?("<url/>")
  end

  def test_saving_xml_when_404
    @api.save_path = SAVE_PATH
    alliances = nil
    assert_raise Errno::ENOENT do
      alliances = @api.alliances :url => File.join(XML_BASE,rand.to_s)
    end
    assert_nil @api.cached_until
    assert_equal 0, Dir.glob(File.join(SAVE_PATH,'alliances','*.xml')).size # no XML saved
  end

  # File.split exists and File is not a String or URI class as permitted in Reve::API#get_xml.
  # This means as a parameter it will pass through Reve::API#compute_hash method and
  # get to Reve::API#get_xml
  def test_for_bad_uri_passed_to_method
    assert_raise Reve::Exceptions::ReveNetworkStatusException do
      @api.character_sheet :url => File
    end
  end

  # def test_check_exception_with_bad_xml_document
  #
  #   assert_raise TypeError do
  #     @api.send(:check_exception, nil)
  #   end
  # end

  def test_errors_api_call
    errors = nil
    assert_nothing_raised do
      errors = @api.errors :url => File.join(XML_BASE,'errors.xml')
    end
    assert errors.all? { |e| e.kind_of?(Reve::Classes::APIError) }
    assert_equal 61, errors.size # 61 errors in total
    errors.each do |error|
      assert_not_nil(error.code)
      assert_not_nil(error.text)
    end
  end

  def test_convert_characterids_to_names
    ids = [ 797400947,892008733 ] # CCP Garthagk, Raquel Smith
    names = []
    assert_nothing_raised do
      names = @api.character_name :url => XML_BASE + 'charactername.xml', :ids => ids
    end
    assert_equal 2, names.size
    names.each do |name|
      assert_not_nil(name.name)
      assert_not_nil(name.id)
    end
    actual_names = names.collect { |n| n.name }
    assert actual_names.include?('CCP Garthagk')
    assert actual_names.include?('Raquel Smith')
  end

  def test_convert_characternames_to_ids
    names = [ 'CCP Garthagk', 'Raquel Smith' ] # 797400947,892008733
    ids = []
    assert_nothing_raised do
      ids = @api.names_to_ids :url => XML_BASE + 'characterid.xml', :names => names
    end
    assert_equal 2, ids.size
    ids.each do |id|
      assert_not_nil(id.id)
      assert_not_nil(id.name)
    end
    actual_ids = ids.collect { |n| n.id }
    assert actual_ids.include?(797400947)
    assert actual_ids.include?(892008733)
  end


  def test_faction_war_system_stats_clean(skip_preamble = false,stats = nil)
    Reve::API.faction_war_occupancy_url = XML_BASE + 'map_facwarsystems.xml'
    unless skip_preamble # not best practice but will get the job done!
      stats = nil
      assert_nothing_raised do
        stats = @api.faction_war_system_stats
      end
    end
    assert stats.all? { |s| s.kind_of?(Reve::Classes::FactionWarSystemStatus) }
    assert_equal(4, stats.size)
    stats.each do |sys|
      # can't assert_not_nil faction_id or faction_name since they may be nil
      assert_not_nil(sys.system_id)
      assert_not_nil(sys.system_name)
      assert_not_nil(sys.contested)
    end
    assert_equal(1, stats.select { |s| s.faction_id == 500001 }.size)
    assert_equal(1, stats.select { |s| s.faction_id == 500002 }.size)
    assert_equal(1, stats.select { |s| ! s.contested }.size)
    assert_equal(2, stats.select { |s| s.faction_id.nil? }.size)
    assert_equal(3, stats.select { |s| s.contested }.size)
  end

  def test_faction_war_system_stats_alias_clean
    Reve::API.faction_war_occupancy_url = XML_BASE + 'map_facwarsystems.xml'
    stats = nil
    assert_nothing_raised do
      stats = @api.faction_war_occupancy
    end
    test_faction_war_system_stats_clean(true,stats)
  end

  def test_faction_war_stats_clean
    Reve::API.general_faction_war_stats_url = XML_BASE + 'eve_facwarstats.xml'
    stats = nil
    assert_nothing_raised do
      stats = @api.faction_war_stats
    end
    assert_instance_of(Reve::Classes::EveFactionWarStat, stats)
    assert_equal(1707, stats.kills_yesterday)
    assert_equal(9737, stats.kills_last_week)
    assert_equal(27866, stats.kills_total)
    assert_equal(215674, stats.victory_points_yesterday)
    assert_equal(1738351, stats.victory_points_last_week)
    assert_equal(5613787, stats.victory_points_total)

    assert stats.faction_wars.all? { |w| w.kind_of?(Reve::Classes::FactionWar) }
    assert stats.faction_participants.all? { |w| w.kind_of?(Reve::Classes::FactionwideFactionWarParticpant) }
    assert_equal(8, stats.faction_wars.size)
    assert_equal(4, stats.faction_participants.size)
    stats.faction_wars.each do |war|
      assert_not_nil(war.faction_id)
      assert_not_nil(war.faction_name)
      assert_not_nil(war.against_id)
      assert_not_nil(war.against_name)
    end
    stats.faction_participants.each do |participant|
      assert_not_nil(participant.faction_id)
      assert_not_nil(participant.faction_name)
      assert_not_nil(participant.systems_controlled)
      assert_not_nil(participant.kills_yesterday)
      assert_not_nil(participant.kills_last_week)
      assert_not_nil(participant.kills_total)
      assert_not_nil(participant.victory_points_yesterday)
      assert_not_nil(participant.victory_points_last_week)
      assert_not_nil(participant.victory_points_total)
    end
    assert_not_nil(@api.cached_until)
  end
  def test_personal_factional_war_stats_clean
    Reve::API.personal_faction_war_stats_url = XML_BASE + 'char_facwarstats.xml'
    stats = nil
    assert_nothing_raised do
      stats = @api.personal_faction_war_stats
    end
    assert_instance_of Reve::Classes::PersonalFactionWarParticpant, stats
    assert_equal(500001, stats.faction_id)
    assert_equal("Caldari State", stats.faction_name)
    assert_equal("2008-06-13 20:38:00".to_time, stats.enlisted_at)
    assert_equal(1, stats.current_rank)
    assert_equal(2, stats.highest_rank)
    assert_equal(3, stats.kills_yesterday)
    assert_equal(4, stats.kills_last_week)
    assert_equal(5, stats.kills_total)
    assert_equal(124, stats.victory_points_yesterday)
    assert_equal(124, stats.victory_points_last_week)
    assert_equal(506, stats.victory_points_total)
  end

  def test_corporate_factional_war_stats_clean
    Reve::API.corporate_faction_war_stats_url = XML_BASE + 'corp_facwarstats.xml'
    stats = nil
    assert_nothing_raised do
      stats = @api.corporate_faction_war_stats
    end
    assert_instance_of Reve::Classes::CorporateFactionWarParticpant, stats
    assert_equal(500001, stats.faction_id)
    assert_equal("Caldari State", stats.faction_name)
    assert_equal("2008-06-10 22:10:00".to_time, stats.enlisted_at)
    assert_equal(4, stats.pilots)
    assert_equal(3, stats.kills_yesterday)
    assert_equal(4, stats.kills_last_week)
    assert_equal(5, stats.kills_total)
    assert_equal(124, stats.victory_points_yesterday)
    assert_equal(906, stats.victory_points_last_week)
    assert_equal(2690, stats.victory_points_total)
  end

  def test_faction_war_top_stats_clean
    Reve::API.top_faction_war_stats_url = XML_BASE + 'eve_facwartopstats.xml'
    stats = nil
    assert_nothing_raised do
      stats = @api.faction_war_top_stats
    end
    assert_kind_of(Reve::Classes::FactionWarTopStats, stats)
    [ :characters, :corporations, :factions ].each do |kind|
      [ :yesterday_kills, :last_week_kills, :total_kills ].each do |attr|
        assert_kind_of(Hash, stats.send(kind))
        assert_kind_of(Array, stats.send(kind)[attr])
        assert ! stats.send(kind)[attr].empty?
        [ :name, :id, :kills ].each do |c_attr|
          assert stats.send(kind)[attr].all? { |e| ! e.nil? }
        end
      end
      [ :last_week_victory_points, :yesterday_victory_points, :total_victory_points ].each do |attr|
        assert_kind_of(Hash, stats.send(kind))
        assert_kind_of(Array, stats.send(kind)[attr])
        assert ! stats.send(kind)[attr].empty?
        [ :name, :id, :victory_points ].each do |c_attr|
          assert stats.send(kind)[attr].all? { |e| ! e.nil? }
        end
      end
    end
    assert_equal(5, stats.characters[:yesterday_kills].size)
    assert_equal(6, stats.characters[:last_week_kills].size)
    assert_equal(7, stats.characters[:total_kills].size)
    [ :yesterday_kills, :yesterday_victory_points, :last_week_kills,
      :last_week_victory_points, :total_kills, :total_victory_points ].each do |attr|
        assert_equal(10,stats.corporations[attr].size)
    end
    [ :yesterday_kills, :yesterday_victory_points, :last_week_kills,
      :last_week_victory_points, :total_kills, :total_victory_points ].each do |attr|
        assert_equal(4,stats.factions[attr].size)
    end
  end


  def test_reftypes_clean
    Reve::API.reftypes_url = XML_BASE + 'reftypes.xml'
    reftypes = nil
    assert_nothing_raised do
      reftypes = @api.ref_types
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 6, reftypes.size
    reftypes.each do |reftype|
      assert_not_nil reftype.id
      assert_not_nil reftype.name
    end
  end


  def test_map_jumps_clean
    Reve::API.map_jumps_url = XML_BASE + 'mapjumps.xml'
    mapjumps = nil
    assert_nothing_raised do
      mapjumps = @api.map_jumps
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 5, mapjumps.size
    mapjumps.each do |jump|
      assert_not_nil jump.system_id
      assert_not_nil jump.jumps
    end
  end

  def test_map_kills_clean
    Reve::API.map_kills_url = XML_BASE + 'mapkills.xml'
    mapkills = nil
    assert_nothing_raised do
      mapkills = @api.map_kills
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 4, mapkills.size
    mapkills.each do |kill|
      assert_not_nil kill.system_id
      assert_not_nil kill.faction_kills
      assert_not_nil kill.ship_kills
      assert_not_nil kill.pod_kills
    end
  end


  def test_member_corporation_sheet_clean
    Reve::API.corporation_sheet_url = XML_BASE + 'corporation_sheet.xml'
    sheet = nil
    assert_nothing_raised do
      sheet = @api.corporation_sheet
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 7, sheet.divisions.size
    assert_equal 7, sheet.wallet_divisions.size
  end

  def test_nonmember_corporation_sheet_clean
    Reve::API.corporation_sheet_url = XML_BASE + 'nonmember_corpsheet.xml'
    sheet = nil
    assert_nothing_raised do
      sheet = @api.corporation_sheet :corporationid => 134300597
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 0, sheet.divisions.size
    assert_equal 0, sheet.wallet_divisions.size
  end

  def test_no_skill_in_training_clean
#    Reve::API.training_skill_url = XML_BASE + 'skill_in_training-none.xml'
    skill = nil
    assert_nothing_raised do
      skill = @api.skill_in_training(:characterid => 1, :url => XML_BASE + 'skill_in_training-none.xml')
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal false, skill.skill_in_training
  end

=begin
    # Tests Reve::API#get_xml's segment that fetches from http
    def test_no_skill_in_training_clean_from_svn
      skill = nil
      assert_nothing_raised do
        skill = @api.skill_in_training(:characterid => 123, :url => URI.parse('http://svn.crudvision.com/reve/trunk/test/xml/skill_in_training-none.xml'))
      end
      assert_not_nil @api.last_hash
      assert_kind_of Time, @api.cached_until
      assert_equal false, skill.skill_in_training
    end
=end

  def test_amarr_titan_skill_in_training_clean
    Reve::API.training_skill_url = XML_BASE + 'skill_in_training-amarr-titan.xml'
    skill = nil
    assert_nothing_raised do
      skill = @api.skill_in_training(:characerid => 1)
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert skill.skill_in_training
    assert_not_nil skill.start_time
    assert_not_nil skill.type_id
    assert_not_nil skill.end_time
    assert_not_nil skill.to_level
    assert_not_nil skill.start_sp
    assert_not_nil skill.end_sp
  end

  def test_skill_queue_clean
    Reve::API.skill_queue_url = XML_BASE + 'skill_queue.xml'
    queue = nil
    assert_nothing_raised do
      queue = @api.skill_queue(:characerid => 1)
    end
    assert_kind_of(Reve::Classes::QueuedSkill, queue.first)
    assert_not_nil queue.first.queue_position
    assert_not_nil queue.first.start_time
    assert_not_nil queue.first.type_id
    assert_not_nil queue.first.end_time
    assert_not_nil queue.first.to_level
    assert_not_nil queue.first.start_sp
    assert_not_nil queue.first.end_sp
    assert_equal 9, queue.length
    Reve::API.skill_queue_url = XML_BASE + 'skill_queue-paused.xml'
    queue = nil
    assert_nothing_raised do
      queue = @api.skill_queue(:characerid => 1)
    end
    assert_kind_of(Reve::Classes::QueuedSkill, queue.first)
    assert_nil queue.first.start_time
    assert_nil queue.first.end_time
  end

#####Test moved to test_reve_failing.rb#######
#  def test_corporate_member_security
#    Reve::API.corporation_member_security_url = XML_BASE + 'corp_membersecurity.xml'
#    members = nil
#    assert_nothing_raised do
#      members = @api.corporate_member_security
#    end
#    assert_equal 2, members.members.size
#    first = members.members.first
#    assert_equal "Test Pilot", first.name
#    assert_equal 194329244, first.id
#    assert_equal 0, first.grantableRoles.size
#    assert_equal 1, first.titles.size
#    last = members.members.last
#    assert_equal 5, last.titles.size
#  end

  def test_personal_notifications
    Reve::API.personal_notification_url = XML_BASE + 'notifications.xml'
    notifications = nil
    assert_nothing_raised do
      notifications = @api.personal_notifications(:characterid => 1)
    end
    assert_equal 2, notifications.length
    assert_equal Reve::Classes::Notification, notifications.first.class
    assert_equal 200076684, notifications.first.sender_id
    assert_equal 16, notifications.first.notification_type_id
    assert_equal Time.parse('2009-12-02 10:54:00 UTC'), notifications.first.send_date
  end

  def test_personal_mailing_lists
    Reve::API.personal_mailing_lists_url = XML_BASE + 'mailing_lists.xml'
    lists = nil
    assert_nothing_raised do
      lists = @api.personal_mailing_lists(:characterid => 1)
    end
    assert_equal 3, lists.length
    assert_equal Reve::Classes::MailingList, lists.first.class
    assert_equal 128250439, lists.first.id
    assert_equal 'EVETycoonMail', lists.first.name
    assert_equal 141157801, lists.last.id
  end

  def test_personal_mail_messages
    Reve::API.personal_mail_messages_url = XML_BASE + 'mail_messages.xml'
    mails = nil
    assert_nothing_raised do
      mails = @api.personal_mail_messages(:characterid => 1)
    end
    assert_equal 5, mails.length
    assert_equal Reve::Classes::MailMessage, mails.first.class
    # Corp Mail
    assert_equal 1, mails.first.sender_id
    assert_equal Time.parse('2013-08-01 01:04:00 UTC').localtime, mails.first.send_date
    assert_equal "Corp mail", mails.first.title
    assert_equal 4, mails.first.to_corp_or_alliance_id
    assert_equal nil, mails.first.to_character_ids
    assert_equal nil, mails.first.to_list_ids
       #assert_equal true, mails.first.read
    # Personal Mail
    assert_equal nil, mails[1].to_corp_or_alliance_id
    assert_equal [5], mails[1].to_character_ids
    assert_equal nil, mails[1].to_list_ids
    # list Mail
    assert_equal nil, mails[2].to_corp_or_alliance_id
    assert_equal nil, mails[2].to_character_ids
    assert_equal [128250439], mails[2].to_list_ids
        #assert_equal false, mails[2].read
    # multi personal
    assert_equal [5,6,7], mails[3].to_character_ids
    # multi list
    assert_equal [128250439,141157801], mails[4].to_list_ids
  end

  def test_personal_mail_messages_with_bodies
    Reve::API.personal_mail_messages_url = XML_BASE + 'mail_messages.xml'
    Reve::API.personal_mail_message_bodies_url = XML_BASE + 'mail_message_bodies.xml'
    mails = nil
    assert_nothing_raised do
      mails = @api.personal_mail_messages(:characterid => 1, :with_bodies => true)
    end
    assert_equal 5, mails.length
    assert_equal Reve::Classes::MailMessage, mails.first.class
    # First
    assert_equal 1, mails.first.sender_id
    assert_equal Time.parse('2013-08-01 01:04:00 UTC').localtime, mails.first.send_date
    assert_equal "Corp mail", mails.first.title
    assert_equal 4, mails.first.to_corp_or_alliance_id
    assert_equal nil, mails.first.to_character_ids
    assert_equal nil, mails.first.to_list_ids
    assert_equal "Hi.<br><br>This is a message about something corporate.<br><br>", mails.first.body
  end

  def test_personal_mail_message_bodies
    Reve::API.personal_mail_message_bodies_url = XML_BASE + 'mail_message_bodies.xml'
    bodies = nil
    assert_nothing_raised do
      bodies = @api.personal_mail_message_bodies(:characterid => 1, :ids => [290285276, 290285275, 290285274, 290285278, 290285279])
    end
    assert_equal 4, bodies.size
    assert_equal ["290285276", "290285275", "290285274", "290285278"], bodies.keys
    assert_equal "Hi.<br><br>This is a message about something corporate.<br><br>", bodies.values.first
    assert_equal '<p>Another message - more personal.</p>', bodies["290285275"]
    # test for the message we did not get a body back for
    assert_nil bodies.fetch("290285279", nil)
  end


  def test_character_info_cleanly
    Reve::API.character_info_url = XML_BASE + 'char_info.xml'
    info = nil
    assert_nothing_raised do
      info = @api.character_info
    end
    assert_equal :basic, info.type
    assert_equal 1643072492, info.id
    assert_equal 'Catari Taga', info.name
    assert_equal 'Caldari', info.race
    assert_equal 'Achura', info.bloodline
    assert_equal 553239300, info.corporation_id
    assert_equal 'Centre Of Attention', info.corporation_name
    assert_equal Time.parse('2009-02-03 13:06:00'), info.corporation_date
    assert_equal 1923227030, info.alliance_id
    assert_equal 'Middle of Nowhere', info.alliance_name
    assert_equal Time.parse('2009-02-03 13:06:00'), info.alliance_date
    assert_equal 0.0, info.security_status
    # limited
    assert_equal nil, info.skillpoints
    assert_equal nil, info.skill_training_ends
    assert_equal nil, info.ship_name
    assert_equal nil, info.ship_type_id
    assert_equal nil, info.ship_type_name
  end

  def test_character_info_limited_cleanly
    Reve::API.character_info_url = XML_BASE + 'char_info_limited.xml'
    info = nil
    assert_nothing_raised do
      info = @api.character_info
    end
    assert_equal :limited, info.type
    assert_equal 9999, info.skillpoints
    assert_equal Time.parse('2010-10-10 08:10:48'), info.skill_training_ends
    assert_equal '.', info.ship_name
    assert_equal 24694, info.ship_type_id
    assert_equal 'Maelstrom', info.ship_type_name
    # full
    assert_equal nil, info.last_known_location
    assert_equal nil, info.account_balance
  end

  def test_character_info_full_cleanly
    Reve::API.character_info_url = XML_BASE + 'char_info_full.xml'
    info = nil
    assert_nothing_raised do
      info = @api.character_info
    end
    assert_equal :full, info.type
    assert_equal 'FD-MLJ VII - Moon 2 - Intaki Bank Investment Bank', info.last_known_location
    assert_equal 9999.29, info.account_balance
  end
  # Can we reassign a URL?
  def test_assignment
    assert_nothing_raised do
      Reve::API.character_sheet_url = "hello"
    end
  end

  # Laziness pays off I hope
  def test_all_raise_errors
    Dir.glob(File.join(XML_BASE,'errors','*.xml')).each do |file|
      # Using begin/rescue/assert here because assert_raise doesn't work with.
      # the exception superclass.
      begin
        @api.send(:check_exception, (File.open(file).read))
      rescue Exception => e
        assert e.kind_of?(Reve::Exceptions::ReveError)
      end
    end
  end

  def test_get_xml_from_filesystem
    xmldoc = @api.send(:get_xml, File.join(XML_BASE, 'skill_in_training-none.xml'), {} )
    assert_equal File.open(File.join(XML_BASE, 'skill_in_training-none.xml')).read, xmldoc
  end

=begin
    def test_get_xml_from_web
      xmldoc = @api.send(:get_xml, 'http://svn.crudvision.com/reve/trunk/test/xml/skill_in_training-none.xml', {} )
      assert_equal File.open(File.join(XML_BASE, 'skill_in_training-none.xml')).read, xmldoc
    end
=end

  def test_get_xml_from_filesystem_missing_file
    assert_raise Errno::ENOENT do
      xmldoc = @api.send(:get_xml, File.join(XML_BASE,rand.to_s), {} )
    end
  end
=begin
  # if this starts to fail make sure the 404 ErrorDocument includes '404 Not Found'
  def test_get_xml_from_web_missing_file
    begin
      xmldoc = @api.send(:get_xml, 'http://svn.crudvision.com/reve/trunk/test/' + rand.to_s, {} )
    rescue Exception => e
      assert e.kind_of?(Reve::Exceptions::ReveNetworkStatusException)
      assert e.message.include?('404 Not Found')
    end
  end
=end

  def test_format_url_request_one_arg
    req = @api.send(:format_url_request, { :a => "Hello" })
    assert_equal "?a=Hello", req
  end

  def test_format_url_request_two_args
    req = @api.send(:format_url_request, { :a => "Hello", :world => "b" })
    assert_equal "?a=Hello&world=b", req
  end

  def test_format_url_request_nil_value
    req = @api.send(:format_url_request, { :a => "Hello", :world => nil })
    assert_equal "?a=Hello", req
  end

  # make sure we can make a Time object
  def test_to_time_method
    str = "2008-01-23 10:32:20"
    real = Time.utc(2008,01,23,10,32,20)
    time = nil
    assert_nothing_raised do
      time  = str.to_time
    end
    assert_kind_of Time,time
    assert_equal real,time
  end

  # It's useful to know the version and we'll stick it in the user agent
  # now as well.
  def test_reve_version
    assert_equal(@api.reve_version, Reve::VERSION)
    assert_equal("Reve v#{Reve::VERSION}; http://github.com/lisa/reve", @api.http_user_agent)
  end


#This test verifies that we can connect to the CPP API Server.
#Dont care what data comes back, just as long as data comes back.
#This is expensive and ugly, but important

  #This is commented out in this test filebecause is is being run to much and causing the server to get grumpy
  #Run it from the test_integration.rb file instead and run it less often.

  # def test_End_to_End_Connectivity_Test
  #   api = Reve::API.new
  #   errors = api.errors
  #   assert_not_nil(errors.inspect)
  # end


end
