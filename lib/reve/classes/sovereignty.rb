module Reve #:nodoc
  module Classes #:nodoc

    # Used for the Reve::API#sovereignty call.
    # Attributes
    # * system_id ( Fixnum ) - ID of the System
    # * alliance_id ( Fixnum ) - ID of the Alliance that controls the System
    # * constellation_sovereignty ( Fixnum ) - ID of the Alliance that has Constellation Sovereignty for a given System's Constellation
    # * level ( Fixnum ) - Not sure? Level of Constellation Sovereignty
    # * faction_id ( Fixnum ) - ID of the Faction that controls the System
    # * system_name ( String ) - Name of the System
    # See Also: Alliance, Reve::API#alliances
    # TODO: Find out what constellationSovereignty is
    class Sovereignty
      attr_reader :system_id, :alliance_id, :corporation_id, :factionID, :faction_id, :system_name
      def initialize(elem) #:nodoc:
        @system_id                 = elem['solarSystemID'].to_i
        @alliance_id               = elem['allianceID'] == '0' ? nil : elem['allianceID'].to_i
        @corporation_id             = elem['corporationID'] == '0' ? nil : elem['corporationID'].to_i
        @faction_id                = elem['factionID'] == '0' ? nil : elem['factionID'].to_i
        @system_name               = elem['solarSystemName']
      end
    end

  end
end
