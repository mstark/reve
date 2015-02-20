module Reve #:nodoc
  module Classes #:nodoc

    # It's possible to be killed/attacked by an NPC. In this case character_id, character_name,
    # alliance_id, alliance_name and weapon_type_id will be nil
    # Represents an attacker (attacking a KillVictim) in a Kill
    # Attributes
    # * id ( Fixnum | NilClass ) - ID of the attacker; nil if the attacker was an NPC or not a Character
    # * name ( String | NilClass ) - Name of the attacker; nil if the attacker was an NPC or not a Character
    # * corporation_id ( Fixnum ) - ID of the Corporation that the Character belongs to (could be NPC Corporation!)
    # * corporation_name ( String ) - Name of the Corporation that the Character belongs to (could be NPC Corporation!)
    # * alliance_id ( Fixnum | NilClass ) - ID of the Alliance that the Character belongs to (nil if the KillAttacker doesn't belong to an Alliance)
    # * security_status ( Float ) - Security status of the KillAttacker
    # * damage_done ( Fixnum ) - How much damage the KillAttacker did.
    # * final_blow ( Boolean ) - True if this KillAttacker got the final blow to kill the KillVictim
    # * weapon_type_id ( Fixnum | NilClass ) - Type ID of the (a?) weapon the KillAttacker was firing. (Refer to CCP database dump invtypes)
    # * ship_type_id ( Fixnum ) - Type ID of the ship the KillAttacker was flying. (Refer to CCP database dump invtypes)
    # See Also: Kill, KillLoss, KillVictim, Reve::API#personal_kills, Reve::API#corporate_kills
    class KillAttacker
      attr_reader :id, :name, :corporation_id, :corporation_name, :alliance_id, :alliance_name,
                  :security_status, :damage_done, :final_blow, :weapon_type_id, :ship_type_id, :faction_id, :faction_name
      def initialize(elem) #:nodoc:
        @id = elem['characterID'] == "0" ? nil : elem['characterID'].to_i
        @name = elem['characterName'].empty? ? nil : elem['characterName']
        @corporation_id = elem['corporationID'].to_i
        @corporation_name = elem['corporationName']
        @alliance_id = elem['allianceID'] == "0" ? nil : elem['allianceID'].to_i
        @alliance_name = elem['allianceName'].empty? ? nil : elem['allianceName']
        @faction_id = elem['factionID'] == "0" ? nil : elem['factionID'].to_i
        @faction_name = elem['factionName'].empty? ? nil : elem['factionName']
        @security_status = elem['securityStatus'].to_f
        @damage_done = elem['damageDone'].to_i
        @final_blow = elem['finalBlow'] == "1"
        @weapon_type_id = elem['weaponTypeID'] == "0" ? nil : elem['weaponTypeID'].to_i
        @ship_type_id = elem['shipTypeID'].to_i
      end
    end

  end
end
