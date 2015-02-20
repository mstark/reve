module Reve #:nodoc
  module Classes #:nodoc

    # Part of the CharacterSheet; represents a grantable Corporation title to a
    # Character.
    # Attributes:
    # * id ( Fixnum ) - Bitmask/ID of the title
    # * name ( String ) - Name of the title
    class CorporateTitle
      attr_reader :id, :name
      def initialize(elem) #:nodoc:
        @id = elem['titleID'].to_i
        @name = elem['titleName']
      end
    end

  end
end
