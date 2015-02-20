module Reve #:nodoc
  module Classes #:nodoc

    class StarbaseFuel
      attr_reader :type_id, :quantity
      def initialize(elem) #:nodoc:
        @type_id = elem['typeID'].to_i
        @quantity = elem['quantity'].to_i
      end
    end

  end
end
