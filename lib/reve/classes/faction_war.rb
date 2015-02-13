module Reve #:nodoc:
  module Classes #:nodoc:

    # Represents a single FactionWar between two Factions (e.g., Gallente v. Caldari)
    # Attributes:
    # * faction_id ( Fixnum ) - ID of the belligerant Faction
    # * faction_name ( String ) - Name of the belligerant Faction.
    # * against_id ( Fixnum ) - ID of the Faction that this war is against.
    # * against_name ( String ) - Name of the Faction that this war is against.
    class FactionWar
      attr_reader :faction_id, :faction_name, :against_id, :against_name
      def initialize(elem) #:nodoc:
        @faction_id = elem['factionID'].to_i
        @faction_name = elem['factionName']
        @against_id = elem['againstID'].to_i
        @against_name = elem['againstName']
      end
    end

  end
end
