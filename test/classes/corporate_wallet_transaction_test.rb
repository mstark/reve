require 'test_helper'

class CorporateWalletTransactionTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_corporate_wallet_transactions
    trans = nil
    assert_nothing_raised do
      trans = @api.corporate_wallet_transactions :url => File.join(XML_BASE,'corporate_wallet_transactions.xml')
    end
    assert_equal 1, trans.size
    assert trans.all? { |tran| tran.kind_of?(Reve::Classes::CorporateWalletTransaction) }
    trans.each do |tran|
      [ :created_at, :id, :quantity, :type_name, :type_id, :price,
        :client_id, :client_name, :character_id, :station_id, :station_name, :type,
        :transaction_for, :character_name ].each do |attr|
      assert_not_nil(tran.send(attr))
    end
    assert_instance_of(Time, tran.created_at)
    end
  end

end
