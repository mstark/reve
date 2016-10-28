require 'test_helper'

class WalletTransactionTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_wallet_transactions
    Reve::API.personal_wallet_trans_url = XML_BASE + 'market_transactions.xml'
    trans = nil
    assert_nothing_raised do
      trans = @api.personal_wallet_transactions(:characterid => 1)
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_instance_of Reve::Classes::PersonalWalletTransaction, trans.first
    assert_equal 9, trans.size
    trans.each do |t|
      assert_not_nil t.created_at
      assert_not_nil t.id
      assert_not_nil t.quantity
      assert_not_nil t.type_name
      assert_not_nil t.type_id
      assert_not_nil t.price
      assert_not_nil t.client_name
      assert_not_nil t.station_id
      assert_not_nil t.station_name
      assert_not_nil t.type
    end
  end

end
