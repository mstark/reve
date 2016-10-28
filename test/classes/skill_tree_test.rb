require 'test_helper'

class SkillTreeTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_skill_tree
    Reve::API.skill_tree_url = XML_BASE + 'skilltree.xml'
    skilltrees = nil
    assert_nothing_raised do
      skilltrees = @api.skill_tree
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 2, skilltrees.size
    skilltrees.each do |skill|
      assert_not_nil skill.type_id
      assert_not_nil skill.name
      assert_not_nil skill.rank
      assert_not_nil skill.description
      skill.bonuses.each do |bonus|
        assert_kind_of Reve::Classes::SkillBonus, bonus
      end
      skill.attribs.each do |attrib|
        assert_kind_of Reve::Classes::RequiredAttribute, attrib
      end
      skill.required_skills.each do |req|
        assert_kind_of Reve::Classes::SkillRequirement, req
      end
    end
  end

end
