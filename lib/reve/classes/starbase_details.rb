module Reve #:nodoc
  module Classes #:nodoc

    # Returns the starbase details for the Starbase whose item id is starbase_id
    # Attributes
    # * state ( Fixnum ) - State of the starbase (Refer to CCP database dump invtypes)
    # * state_timestamp ( Time ) - Depents on state
    # * online_timestamp ( Time ) - Since when this starbase is online
    # * general_settings ( StarbaseGeneralSettings ) - See StarbaseGeneralSettings
    # * combat_settings ( StarbaseCombatSettings ) - See StarbaseCombatSettings
    # * fuel ( [StarbaseFuel ] ) - See StarbaseFuel
    # See Also: Starbase, StarbaseGeneralSettings, StarbaseCombatSettings, StarbaseFuel, Reve::API#starbase_details, Reve::API#starbases
    class StarbaseDetails
      attr_reader :state, :state_timestamp, :online_timestamp
      attr_accessor :general_settings, :combat_settings, :fuel

      def initialize(elem, general_settings, combat_settings, fuel) #:nodoc:
        @state = elem[:state].to_i
        @state_timestamp = elem[:state_timestamp].to_time
        @online_timestamp = elem[:online_timestamp].to_time
        @general_settings = general_settings
        @combat_settings = combat_settings
        @fuel = fuel
      end
    end

  end
end
