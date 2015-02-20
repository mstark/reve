module Reve #:nodoc
  module Classes #:nodoc

    class FactionWarKills
      attr_reader :kills
      def initialize(elem) #:nodoc:
        @kills = elem['kills'].to_i
      end
    end

  end
end
