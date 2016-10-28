require 'test_helper'

class PersonalContactTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_personal_contacts_clean
    Reve::API.personal_contacts_url = XML_BASE + 'char_contacts.xml'
    contacts = @api.personal_contacts
    assert_equal(2, contacts.length)
    assert_equal("Hirento Raikkanen", contacts.first.contact_name )
    assert_equal(3010913, contacts.first.contact_id )
    assert_equal(false, contacts.first.in_watchlist )
    assert_equal(0, contacts.first.standing )
  end

  def test_corporate_contacts_clean
    Reve::API.corporate_contacts_url = XML_BASE + 'corp_contact.xml'
    contacts = @api.corporate_contacts
    assert_equal(2, contacts.length)
    assert_equal("CCP Garthagk", contacts.first.contact_name )
    assert_equal(797400947, contacts.first.contact_id )
    assert_equal(false, contacts.first.in_watchlist )
    assert_equal(-10, contacts.first.standing )
    assert_equal(Reve::Classes::CorporateContact, contacts.first.class )

    assert_equal("CCP Garthagk", contacts.last.contact_name )
    assert_equal(797400947, contacts.last.contact_id )
    assert_equal(false, contacts.last.in_watchlist )
    assert_equal(5, contacts.last.standing )
    assert_equal(Reve::Classes::AllianceContact, contacts.last.class )
  end

end