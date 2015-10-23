require 'test_helper'

class ResearchTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end


  def test_research_api_call
    Reve::API.research_url = XML_BASE + 'research.xml'
    research = nil
    assert_nothing_raised do
      research = @api.research :characterid => 123
    end
    assert_not_nil(research)
    assert_not_nil(@api.last_hash)
    assert_equal(4, research.size)
    research.each do |ri|
      assert_kind_of(Fixnum, ri.agent_id)
      assert_kind_of(Fixnum, ri.skill_type_id)
      assert_kind_of(Time, ri.research_started_at)
      assert_kind_of(Float, ri.points_per_day)
      assert_kind_of(Float, ri.remainder_points)
    end
  end

end
