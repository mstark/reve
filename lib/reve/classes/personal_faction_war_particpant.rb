require_relative 'faction_war_particpant'

module Reve #:nodoc:
  module Classes #:nodoc:

    # Represents a Character's stats as a FactionWarParticpant.
    # Attributes:
    # * (See FactionWarParticpant for more)
    # * current_rank ( Fixnum ) - Current Rank
    # * highest_rank ( Fixnum ) - Highest Rank
    # * enlisted_at ( Time ) - When the participant enlisted into the Faction
    class PersonalFactionWarParticpant < FactionWarParticpant
      attr_reader :current_rank, :highest_rank
      def initialize(elem) #:nodoc:
        super(elem)
        @current_rank = elem['currentRank'].to_i
        @highest_rank = elem['highestRank'].to_i
        @enlisted_at = elem['enlisted'].to_time
      end
    end

  end
end
