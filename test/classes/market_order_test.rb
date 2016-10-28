require 'test_helper'

class MarketOrderTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_market_orders
    Reve::API.personal_market_orders_url = XML_BASE + 'marketorders.xml'
    orders = nil
    assert_nothing_raised do
      orders = @api.personal_market_orders
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 11, orders.size
    buys = sells = 0
    orders.each do |order|
      [ :id, :character_id, :station_id, :volume_entered, :volume_remaining, :minimum_volume,
      :order_state, :type_id, :range, :account_key, :duration, :escrow, :price, :bid ].each do |attr|
        assert_not_nil(order.send(attr))
      end
      assert_kind_of Time, order.created_at
      assert [TrueClass, FalseClass].include?(order.bid.class)
      buys  += 1 if ! order.bid
      sells += 1 if   order.bid
      assert_not_equal(0, order.character_id)
    end
    assert_equal 4, buys
    assert_equal 7, sells
  end

  def test_corporate_market_orders
    orders = nil
    assert_nothing_raised do
      orders = @api.corporate_market_orders :url => File.join(XML_BASE,'corporate_market_orders.xml')
    end
    assert_not_nil @api.last_hash
    assert_kind_of Time, @api.cached_until
    assert_equal 1, orders.size
    buys = sells = 0
    orders.each do |order|
      [ :id, :character_id, :station_id, :volume_entered, :volume_remaining, :minimum_volume,
      :order_state, :type_id, :range, :account_key, :duration, :escrow, :price, :bid ].each do |attr|
        assert_not_nil(order.send(attr))
      end
      assert_kind_of Time, order.created_at
      assert [TrueClass, FalseClass].include?(order.bid.class)
      buys  += 1 if ! order.bid
      sells += 1 if   order.bid
    end
    assert_equal 1, buys
    assert_equal 0, sells
  end

end
