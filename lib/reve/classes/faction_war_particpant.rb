module Reve #:nodoc:
  module Classes #:nodoc:

    # Maps a participant in a FactionWar. Can be a:
    # * PersonalFactionWarParticpant
    # * CorporateFactionWarParticpant
    # * FactionwideFactionWarParticpant
    # Attributes:
    # * faction_id ( Fixnum ) - ID of the Faction to which the participant belongs
    # * faction_name ( String ) - Name of the Faction
    # * kills_yesterday ( Fixnum )
    # * kills_last_week ( Fixnum )
    # * kills_total ( Fixnum )
    # * victory_points_yesterday ( Fixnum )
    # * victory_points_last_week ( Fixnum )
    # * victory_points_total ( Fixnum )
    class FactionWarParticpant
      attr_reader :faction_id, :faction_name, :enlisted_at, :kills_yesterday,
                  :kills_last_week, :kills_total, :victory_points_yesterday,
                  :victory_points_last_week, :victory_points_total
      def initialize(elem) #:nodoc:
        @faction_id = elem['factionID'].to_i
        @faction_name = elem['factionName']
        @kills_yesterday = elem['killsYesterday'].to_i
        @kills_last_week = elem['killsLastWeek'].to_i
        @kills_total = elem['killsTotal'].to_i
        @victory_points_yesterday = elem['victoryPointsYesterday'].to_i
        @victory_points_last_week = elem['victoryPointsLastWeek'].to_i
        @victory_points_total = elem['victoryPointsTotal'].to_i
      end
    end

  end
end
