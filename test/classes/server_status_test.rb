require 'test_helper'

class ServerStatusTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_server_status
    Reve::API.server_status_url = XML_BASE + 'server_status.xml'
    status = nil
    assert_nothing_raised do
      status = @api.server_status
    end
    assert_kind_of(Reve::Classes::ServerStatus, status)
    assert_equal(34444, status.players)
    assert status.open?
    assert status.open
  end

end
