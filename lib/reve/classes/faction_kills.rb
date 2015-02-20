require_relative 'faction_war_kills'

module Reve #:nodoc
  module Classes #:nodoc

    class FactionKills < FactionWarKills
      attr_reader :name, :id
      def initialize(elem) #:nodoc:
        super(elem)
        @name = elem['factionName']
        @id = elem['factionID'].to_i
      end
    end

  end
end
