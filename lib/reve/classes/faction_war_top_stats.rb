module Reve #:nodoc
  module Classes #:nodoc

    # Faction War Top Stats. This is different than the rest of the classes.
    # Each attribute on this class is a Hash with the following keys:
    # * yesterday_kills ( Array )
    # * yesterday_victory_points ( Array )
    # * last_week_kills ( Array )
    # * last_week_victory_points ( Array )
    # * total_kills ( Array )
    # * total_victory_points ( Array )
    # The value of each key is an Array whose class is specified below (under 'Attributes' list) for each Attribute.
    # Attributes:
    # * characters ( Hash ) - CharacterFactionVictoryPoints, CharacterFactionKills
    # * corporations ( Hash ) - CorporationFactionVictoryPoints, CorporationFactionKills
    # * factions ( Hash ) - FactionVictoryPoints, FactionWarKills
    # Access: Reve::API#faction_war_top_stats.characters[:yesterday_kills] => array of CharacterFactionKills objects.
    class FactionWarTopStats
      attr_reader :characters, :corporations, :factions
      def initialize(characters, corporations, factions) #:nodoc:
        @characters = characters
        @corporations = corporations
        @factions = factions
      end
    end

  end
end
