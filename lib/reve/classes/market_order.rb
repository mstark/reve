module Reve #:nodoc
  module Classes #:nodoc

    # Used for the Reve::API#personal_market_orders and Reve::API#corporate_market_orders
    # Each of those derrive from this parent class.
    # Attributes
    # * id ( Fixnum ) - ID of the MarketOrder. This is a CCP internal ID and is not guaranteed to always be unique! You may want to generate your own globally unique ID for this.
    # * character_id ( Fixnum ) - ID of the Character who set this MarketOrder up
    # * station_id ( Fixnum ) - ID of the Station where the MarketOrder is
    # * volume_entered ( Fixnum ) - How many of +type_id+ was initially entered in the MarketOrder
    # * volume_remaining ( Fixnum ) - How many of +type_id+ is left in the MarketOrder
    # * minimum_volume ( Fixnum ) - How much of +type_id+ can be transacted (as a minimum) at once
    # * order_state ( String ) - String representation of the MarketOrder's current state. Options are: Active, Closed, Expired, Cancelled, Pending, Character Deleted
    # * type_id ( Fixnum ) - Type ID of item for which the MarketOrder was created. (Refer to CCP database dump invtypes)
    # * range ( Fixnum ) - Range of the MarketOrder. For sell orders it is always 32767 (Entire Region), for sell orders the values are -1 (Station only), 0 (Solar system), 1..40 (Number of jumps away from the Station), 32767 (Region wide)
    # * account_key ( Fixnum ) - For a CorporateMarketOrder the account key (see WalletDivision and CorporationSheet) that was used as the source/destination.
    # * duration ( Fixnum ) - Duration of the MarketOrder in days from when it was +created_at+
    # * escrow ( Float ) - How much ISK is held in escrow for the MarketOrder
    # * price ( Float ) - Unit price of the item in the MarketOrder
    # * bid ( Boolean ) - True if this MarketOrder is a sell order, false otherwise
    # * created_at ( Time ) - When the MarketOrder was created
    # See Also: CorporationSheet, WalletDivision, CorporateDivision, Reve::API#personal_market_orders, Reve::API#corporate_market_orders
    class MarketOrder
      attr_reader :id, :character_id, :station_id, :volume_entered, :volume_remaining, :minimum_volume,
                  :order_state, :type_id, :range, :account_key, :duration, :escrow, :price, :bid, :created_at
      def initialize(elem) #:nodoc:
        @id = elem['orderID'].to_i
        @character_id = elem['charID'].to_i
        @station_id = elem['stationID'].to_i
        @volume_entered = elem['volEntered'].to_i
        @volume_remaining = elem['volRemaining'].to_i
        @minimum_volume = elem['minVolume'].to_i
        @order_state = case elem['orderState'].to_i
                       when 0
                         'Active'
                       when 1
                         'Closed'
                       when 2
                         'Expired'
                       when 3
                         'Cancelled'
                       when 4
                         'Pending'
                       when 5
                         'Character Deleted'
                       end
        @type_id = elem['typeID'].to_i
        @range = elem['range'].to_i
        @account_key = elem['accountKey'].to_i
        @escrow = elem['escrow'].to_f
        @price = elem['price'].to_f
        @bid = elem['bid'] == '1'
        @duration = elem['duration'].to_i
        @created_at = elem['issued'].to_time
      end
    end

    class PersonalMarketOrder < MarketOrder; end
    class CorporateMarketOrder < MarketOrder; end

  end
end
