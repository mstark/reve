require_relative 'faction_war_particpant'

module Reve #:nodoc:
  module Classes #:nodoc:

    # Represents a Corpration's stats as a FactionWarParticpant.
    # Attributes:
    # * (See FactionWarParticpant for more)
    # * pilots ( Fixnum ) - Number of pilots (Characters) in the Corporation
    # * enlisted_at ( Time ) - When the participant enlisted into the Faction
    class CorporateFactionWarParticpant < FactionWarParticpant
      attr_reader :pilots
      def initialize(elem) #:nodoc:
        super(elem)
        @pilots = elem['pilots'].to_i
        @enlisted_at = elem['enlisted'].to_time
      end
    end

  end
end
