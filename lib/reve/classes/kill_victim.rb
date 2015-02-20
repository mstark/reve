module Reve #:nodoc
  module Classes #:nodoc

    # Represents the victim of a Kill.
    # Attributes:
    # * id ( Fixnum ) - ID of the Character that was killed.
    # * name ( String ) - The name of the Character that was killed.
    # * corporation_id ( Fixnum ) - The ID of the Corporation that the victim belongs to.
    # * corporation_name ( String ) - Name of the Corporation that the victim belongs to.
    # * alliance_id ( Fixnum | NilClass ) - The ID of the Alliance that the victim belongs to, if applicable. Will be nil unless the victim was in an Alliance
    # * alliance_name ( String  | NilClass ) - Name of the Alliance the Character is in, if any.
    # * damage_taken ( Fixnum ) - The amount of damage the victim took before being killed.
    # * ship_type_id ( Fixnum ) - ID of the ship type (references CCP data dump) that the victim was flying.
    # See Also: KillAttacker, Kill, KillLoss, Reve::API#personal_kills, Reve::API#corporate_kills
    class KillVictim
      attr_reader :id, :name, :corporation_id, :corporation_name, :alliance_id, :damage_taken, :ship_type_id, :faction_id, :faction_name
      def initialize(elem) #:nodoc:
        @id = elem['characterID'].to_i
        @name = elem['characterName']
        @corporation_id = elem['corporationID']
        @corporation_name = elem['corporationName']
        @alliance_id = elem['allianceID'] == "0" ? nil : elem['allianceID'].to_i
        @faction_id = elem['factionID'] == "0" ? nil : elem['factionID'].to_i
        @faction_id = elem['factionID'] == "0" ? nil : elem['factionID'].to_i
        @faction_name = elem['factionName'].empty? ? nil : elem['factionName']
        @alliance_name = elem['allianceName'].empty? ? nil : elem['allianceName']
        @damage_taken = elem['damageTaken'].to_i
        @ship_type_id = elem['shipTypeID'].to_i
      end
    end

  end
end
