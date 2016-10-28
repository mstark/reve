require 'test_helper'

class IndustryJobTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_personal_industry_jobs
    Reve::API.personal_industry_jobs_url = XML_BASE + 'industryjobs.xml'
    jobs = nil
    assert_nothing_raised do
      jobs = @api.personal_industry_jobs
    end
    assert_equal 2, jobs.size
    # All things got assigned something.
    jobs.each do |job|
      [ :id, :assembly_line_id, :container_id, :installed_item_id, :installed_item_location_id,
        :installed_item_quantity, :installed_item_productivity_level, :installed_item_material_level,
        :installed_item_licensed_production_runs_remaining, :output_location_id, :installer_id, :runs,
        :licensed_production_runs, :installed_system_id, :container_location_id, :material_multiplier,
        :char_material_multiplier, :time_multiplier, :char_time_multiplier, :installed_item_type_id,
        :output_type_id, :container_type_id, :installed_item_copy, :completed, :completed_successfully,
        :installed_item_flag, :output_flag, :activity_id, :completed_status, :installed_at,
        :begin_production_at, :end_production_at, :pause_production_time ].each do |att|
          assert_not_nil job.send(att)
      end
    end
    assert jobs.last.installed_system_id != 0
  end

  def test_corporate_industry_jobs
    Reve::API.corporate_industry_jobs_url = XML_BASE + 'industryjobs.xml'
    jobs = nil
    assert_nothing_raised do
      jobs = @api.corporate_industry_jobs
    end
    assert_equal 2, jobs.size
    # All things got assigned something.
    jobs.each do |job|
      [ :id, :assembly_line_id, :container_id, :installed_item_id, :installed_item_location_id,
        :installed_item_quantity, :installed_item_productivity_level, :installed_item_material_level,
        :installed_item_licensed_production_runs_remaining, :output_location_id, :installer_id, :runs,
        :licensed_production_runs, :installed_system_id, :container_location_id, :material_multiplier,
        :char_material_multiplier, :time_multiplier, :char_time_multiplier, :installed_item_type_id,
        :output_type_id, :container_type_id, :installed_item_copy, :completed, :completed_successfully,
        :installed_item_flag, :output_flag, :activity_id, :completed_status, :installed_at,
        :begin_production_at, :end_production_at, :pause_production_time ].each do |att|
          assert_not_nil job.send(att)
      end
    end
  end

end
