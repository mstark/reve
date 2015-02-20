module Reve #:nodoc
  module Classes #:nodoc
    # The status of a System with regards to a FactionWar. Who controls what
    # and what System is contested
    # Attributes:
    # * system_id ( Fixnum ) - ID of the System
    # * system_name ( String ) - Name of the System
    # * faction_id ( Fixnum | NilClass ) - ID of the Faction that is occupying this System. If no Faction controls this System this will be nil.
    # * faction_name ( String | NilClass ) - Name of the Faction that is occupying this System. If no Faction controls this System this will be nil.
    # * contested ( Boolean ) - Is this System contested?
    class FactionWarSystemStatus
      attr_reader :system_id, :system_name, :faction_id, :faction_name, :contested
      def initialize(elem) #:nodoc:
        @system_id = elem['solarSystemID'].to_i
        @system_name = elem['solarSystemName']
        @faction_id = elem['occupyingFactionID'].to_i
        @faction_name = elem['occupyingFactionName']
        @contested = elem['contested'] == 'True'
        if @faction_id == 0
          @faction_id = nil
          @faction_name = nil
        end
      end
    end
  end
end
