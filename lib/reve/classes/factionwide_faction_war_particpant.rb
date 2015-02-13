require_relative 'faction_war_particpant'

module Reve #:nodoc:
  module Classes #:nodoc:

    # Represents an entire Faction's stats as a FactionWarParticpant.
    # Attributes:
    # * (See FactionWarParticpant for more)
    # * pilots ( Fixnum ) - Number of pilots (Characters) in the Corporation
    class FactionwideFactionWarParticpant < FactionWarParticpant
      attr_reader :pilots, :systems_controlled
      def initialize(elem) #:nodoc:
        super(elem)
        @pilots = elem['pilots'].to_i
        @systems_controlled = elem['systemsControlled'].to_i
      end
    end

  end
end
