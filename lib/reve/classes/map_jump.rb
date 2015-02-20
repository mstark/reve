module Reve #:nodoc
  module Classes #:nodoc

    # Used for the Reve::API#map_jumps method. If there are no jumps it is not listed.
    # Attributes
    # * system_id ( Fixnum ) - ID of the System
    # * jumps ( Fixnum ) - Number of jumps through the System
    # See Also: MapKill, Reve::API#map_jumps
    class MapJump
      attr_reader :system_id, :jumps
      def initialize(elem) #:nodoc:
        @system_id = elem['solarSystemID'].to_i
        @jumps     = elem['shipJumps'].to_i
      end
    end

  end
end
