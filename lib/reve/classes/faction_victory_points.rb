require_relative 'faction_war_victory_points'

module Reve #:nodoc
  module Classes #:nodoc

   class FactionVictoryPoints < FactionWarVictoryPoints
     attr_reader :name, :id
     def initialize(elem) #:nodoc:
       super(elem)
       @name = elem['factionName']
       @id = elem['factionID'].to_i
     end
   end

  end
end
