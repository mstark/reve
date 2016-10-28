require 'test_helper'

class WalletJournalTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_corporate_wallet_journal_clean
    journal = nil
    assert_nothing_raised do
      journal = @api.corporate_wallet_journal :url => File.join(XML_BASE,'corporate_wallet_journal.xml')
    end
    assert_equal 3, journal.size
    assert journal.all? { |j| j.kind_of?(Reve::Classes::WalletJournal) }
    journal.each do |j|
      [ :date, :ref_id, :reftype_id, :owner_name1, :owner_name2, :arg_name1, :amount, :balance, :reason , :tax_amount, :tax_receiver_id].each do |attr|
        assert_not_nil(j.send(attr))
      end
    end
  end

  def test_wallet_journal_clean
    Reve::API.personal_wallet_journal_url = XML_BASE + 'wallet_journal.xml'
    journal = nil
    assert_nothing_raised do
      journal = @api.personal_wallet_journal(:characterid => 1)
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 8, journal.size
    journal.each do |j|
      assert_not_nil j.date
      assert_not_nil j.ref_id
      assert_not_nil j.reftype_id
      assert_not_nil j.owner_name1
      assert_not_nil j.owner_name2
      assert_not_nil j.arg_name1
      assert_not_nil j.amount
      assert_not_nil j.balance
      assert_not_nil j.reason
    end
  end

end
