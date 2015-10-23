require 'test_helper'

class CorporationSheetTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_corporation_sheet_clean
    Reve::API.corporation_sheet_url = XML_BASE + 'corporation_sheet.xml'
    corporation = nil
    assert_nothing_raised do
      corporation = @api.corporation_sheet(:characterid => 123)
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 150212025, corporation.id
    assert_equal "Banana Republic", corporation.name
    assert_equal "BR", corporation.ticker
    assert_equal(150208955, corporation.ceo_id)
    assert_equal("Mark Roled", corporation.ceo_name)
    assert_equal(60003469, corporation.station_id)
    assert_equal("Jita IV - Caldari Business Tribunal Information Center", corporation.station_name)
    assert_equal "Garth's testing corp of awesome sauce, win sauce as it were. In this corp...<br><br>IT HAPPENS ALL OVER", corporation.description
    assert_equal("", corporation.url)
    assert_equal(150430947, corporation.alliance_id)
    assert_equal("The Dead Rabbits", corporation.alliance_name)
    assert_equal 93.7, corporation.tax_rate
    assert_equal(3, corporation.member_count)
    assert_equal(6300, corporation.member_limit)
    assert_equal(1, corporation.shares)
    assert_equal "DIVISION", corporation.divisions.select { |d| d.key == 1003 }.first.description
    corporation.divisions.each do |d|
      assert_not_nil(d.key)
      assert_not_nil(d.description)
    end
    assert_equal "Master Wallet", corporation.wallet_divisions.select { |d| d.key == 1000 }.first.description
    corporation.wallet_divisions.each do |wd|
      assert_not_nil(wd.key)
      assert_not_nil(wd.description)
    end
    assert_equal 0, corporation.logo.graphic_id
    assert_equal 681, corporation.logo.color_1
    assert_equal 676, corporation.logo.color_2
    assert_equal 448, corporation.logo.shape_1
    assert_equal 418, corporation.logo.shape_3
    assert_equal 0, corporation.logo.color_3
    assert_equal 0, corporation.logo.shape_2
  end

end
