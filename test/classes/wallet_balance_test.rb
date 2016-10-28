require 'test_helper'

class WalletBalanceTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_corporate_wallet_balance_clean
    balance = nil
    assert_nothing_raised do
      balance = @api.corporate_wallet_balance :url => File.join(XML_BASE, 'corporate_wallet_balance.xml')
    end
    assert balance.all? { |b| b.kind_of?(Reve::Classes::WalletBalance) }
    balance.each do |bal|
      assert_not_nil(bal.account_id)
      assert_not_nil(bal.account_key)
      assert_not_nil(bal.balance)
    end
    assert_equal 18004409.84, balance.select { |b| b.account_key == '1000' }.first.balance
    balance.select { |b| b.account_key != '1000' }.each do |non_tested_account|
      assert_equal 0.00, non_tested_account.balance
    end
  end

  def test_wallet_balance_clean
    Reve::API.personal_wallet_balance_url = XML_BASE + 'wallet_balance.xml'
    balance = nil
    assert_nothing_raised do
      balance = @api.personal_wallet_balance(:characterid => 1)
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 7, balance.size
    balance.each do |bal|
      assert_not_nil bal.account_id
      assert_not_nil bal.account_key
      assert_not_nil bal.balance
    end
  end

end
