module Reve #:nodoc:
  module Classes #:nodoc:

    class EveFactionWarStat
      attr_accessor :faction_participants, :faction_wars
      attr_reader :kills_yesterday, :kills_last_week, :kills_total,
                  :victory_points_yesterday, :victory_points_last_week,
                  :victory_points_total
      def initialize(elem, wars, participants) #:nodoc:
        @faction_wars = wars
        @faction_participants = participants
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
