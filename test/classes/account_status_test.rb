require 'test_helper'

class AccountStatusTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_account_status
    Reve::API.account_status_url = XML_BASE + 'account_status.xml'
    status = nil
    assert_nothing_raised do
      status = @api.account_status
    end
    assert_equal 3000000, status.user_id
    assert_equal Time.parse("2004-01-01 00:00:00"), status.created_at
    assert_equal Time.parse("2011-01-01 00:00:00"), status.paid_until
    assert_equal 9998, status.logon_count
    assert_equal 9999, status.logon_minutes
  end

end
