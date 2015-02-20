require_relative 'faction_war_kills'

module Reve #:nodoc
  module Classes #:nodoc

    class CorporationFactionKills < FactionWarKills
      attr_reader :name, :id
      def initialize(elem) #:nodoc:
        super(elem)
        @name = elem['corporationName']
        @id = elem['corporationID'].to_i
      end
    end

  end
end
