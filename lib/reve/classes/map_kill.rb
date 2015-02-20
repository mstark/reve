module Reve #:nodoc
  module Classes #:nodoc

    # Used for the Reve::API#map_kills method. If there are no kills it's not listed.
    # Attributes
    # * system_id ( Fixnum ) - ID of the System
    # * ship_kills ( Fixnum ) - Number of ships killed
    # * faction_kills ( Fixnum ) - Number of faction ships killed (NPC Pirates)
    # * pod_kills ( Fixnum ) - Number of podkills
    # See also Reve::API#map_kills, MapJump
    class MapKill
      attr_reader :system_id, :ship_kills, :faction_kills, :pod_kills
      def initialize(elem) #:nodoc:
        @system_id     = elem['solarSystemID'].to_i
        @ship_kills    = elem['shipKills'].to_i
        @faction_kills = elem['factionKills'].to_i
        @pod_kills     = elem['podKills'].to_i
      end
    end

  end
end
