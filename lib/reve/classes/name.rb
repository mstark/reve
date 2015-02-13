module Reve #:nodoc:
  module Classes #:nodoc:

    class Name
      attr_reader :id, :name
      def initialize(elem) #:nodoc:
        @id = elem['id'].to_i
        @id = elem['name']
      end
    end

  end
end
