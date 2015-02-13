module Reve #:nodoc:
  module Classes #:nodoc:

    # Only for use in Alliance class (member_corporations array) from the Reve::API#alliances call
    # Attributes
    # * id ( Fixnum ) - ID of the Corporation (use this in the Reve::API#corporation_sheet call)
    # * start_date ( Time ) - When the Corporation was started?
    class Corporation
      attr_reader :id, :start_date
      def initialize(elem) #:nodoc:
        @id = elem['corporationID'].to_i
        @start_date = elem['startDate'].to_time
      end
    end

  end
end
