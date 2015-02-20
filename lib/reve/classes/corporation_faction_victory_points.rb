require_relative 'faction_war_victory_points'

module Reve #:nodoc
  module Classes #:nodoc

    class CorporationFactionVictoryPoints < FactionWarVictoryPoints
      attr_reader :name, :id
      def initialize(elem) #:nodoc:
        super(elem)
        @name = elem['corporationName']
        @id = elem['corporationID'].to_i
      end
    end

  end
end
