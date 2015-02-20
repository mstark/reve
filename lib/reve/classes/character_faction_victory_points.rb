require_relative 'faction_war_victory_points'

module Reve #:nodoc
  module Classes #:nodoc

    class CharacterFactionVictoryPoints < FactionWarVictoryPoints
      attr_reader :name, :id
      def initialize(elem) #:nodoc:
        super(elem)
        @name = elem['characterName']
        @id = elem['characterID'].to_i
      end
    end

  end
end
