module Reve #:nodoc
  module Classes #:nodoc

    # ServerStatus object. Simple
    # Attributes:
    # * open ( Boolean ) - true if the server is up, false if it's down
    # * players ( Numeric ) - Number of players online
    # See Also: Reve::API#server_status
    class ServerStatus
      attr_reader :open, :players
      def initialize(open, online) #:nodoc:
        @open = open.downcase == "true"
        @players = online.to_i
      end

      def open?
        @open
      end
    end

  end
end
