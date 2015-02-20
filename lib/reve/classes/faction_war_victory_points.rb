module Reve #:nodoc
  module Classes #:nodoc

    class FactionWarVictoryPoints
      attr_reader :victory_points
      def initialize(elem) #:nodoc:
        @victory_points = elem['victoryPoints'].to_i
      end
    end

  end
end
