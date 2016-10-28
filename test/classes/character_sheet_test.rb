require 'test_helper'

class CharacterSheetTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_character_sheet_clean
    Reve::API.character_sheet_url = XML_BASE + 'character_sheet.xml'
    sheet = nil

    assert_nothing_raised do
      sheet = @api.character_sheet(:characterid => 1)
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until

    assert_not_nil sheet.name
    assert_not_nil sheet.race
    assert_not_nil sheet.ancestry
    assert_not_nil sheet.dob
    assert_not_nil sheet.bloodline
    assert_not_nil sheet.gender
    assert_not_nil sheet.id
    assert_not_nil sheet.corporation_name
    assert_not_nil sheet.corporation_id
    assert_not_nil sheet.balance

    assert_not_nil sheet.intelligence
    assert_not_nil sheet.memory
    assert_not_nil sheet.charisma
    assert_not_nil sheet.perception
    assert_not_nil sheet.willpower

    assert_equal 5, sheet.enhancers.size, "Implant size mismatch"
    sheet.enhancers.each do |enhancer|
      assert_kind_of Reve::Classes::AttributeEnhancer, enhancer
    end
    assert_equal 44842126, sheet.skills.inject(0) { |sum,s| sum += s.skillpoints }, "Skillpoint total mismatch"

    sheet.skills.each do |skill|
      assert_kind_of Reve::Classes::Skill, skill
    end
    assert_equal(57, sheet.certificate_ids.size,"Certificate ID size mismatch")
    assert sheet.certificate_ids.all? { |cid| cid.kind_of?(Fixnum) }

    # role aliases
    assert ! sheet.corporate_roles_at_hq.empty?
    assert ! sheet.corporate_roles.empty?
    assert ! sheet.corporate_roles_at_base.empty?
    assert ! sheet.corporate_roles_at_other.empty?
    # role proper methods
    assert ! sheet.corporationRolesAtHQ.empty?
    assert ! sheet.corporationRoles.empty?
    assert ! sheet.corporationRolesAtBase.empty?
    assert ! sheet.corporationRolesAtOther.empty?

    [ :corporate_roles_at_hq, :corporate_roles, :corporate_roles_at_base, :corporate_roles_at_other ].each do |role_kind|
      r_ary = sheet.send(role_kind)
      assert r_ary.all? { |r| r.kind_of?(Reve::Classes::CorporateRole) }
      assert r_ary.all? { |r| r.name.kind_of?(String) }
      assert r_ary.all? { |r| r.id.kind_of?(Numeric) }
    end

    assert ! sheet.corporate_titles.empty?
    assert sheet.corporate_titles.all? { |t| t.kind_of?(Reve::Classes::CorporateTitle) }
    assert sheet.corporate_titles.all? { |t| t.name.kind_of?(String) }
    assert sheet.corporate_titles.all? { |t| t.id.kind_of?(Numeric) }
  end

end
