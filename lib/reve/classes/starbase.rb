module Reve #:nodoc
  module Classes #:nodoc

    # Used for a list of Starbases, Reve::API#starbases
    # Attributes
    # * type_id ( Fixnum ) - Type of Starbase (Refer to CCP database dump invtypes)
    # * id ( Fixnum ) - ID of the Starbase
    # * system_id ( Fixnum ) - ID of the System where the Starbase is
    # * moon_id ( Fixnum ) - ID of the Moon where the Starbase is
    # * state ( Fixnum ) - Mode of the POS. See Known POS States, below, see: http://wiki.eve-id.net/APIv2_Corp_StarbaseList_XML
    # * state_timestamp ( Time ) - Depends on the state, for example cycle time or Reinforced until
    # * online_timestamp ( Time ) - Since when the starbase is online
    # See Also: StarbaseFuel, Reve::API#starbases, Reve::API#starbase_fuel
    class Starbase
      attr_reader :type_id, :type_name, :id, :system_id, :moon_id, :state, :state_timestamp, :online_timestamp
      alias_method :item_id, :id
      alias_method :location_id,:system_id
      def initialize(elem) #:nodoc:
        @type_id = elem['typeID'].to_i
        @id = elem['itemID'].to_i
        @system_id = elem['locationID'].to_i
        @moon_id = elem['moonID'].to_i
        @state = elem['state'].to_i
        @state_timestamp = elem['stateTimestamp'].to_time
        @online_timestamp = elem['onlineTimestamp'].to_time
      end
    end

  end
end
