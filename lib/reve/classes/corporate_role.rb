module Reve #:nodoc
  module Classes #:nodoc

    # Part of the CharacterSheet; represents a grantable Corporation role to a
    # Character.
    # Attributes:
    # * id ( Fixnum ) - Bitmask/ID of the role
    # * name ( String ) - Name of the role
    class CorporateRole
      attr_reader :id, :name
      def initialize(elem) #:nodoc:
        @id = elem['roleID'].to_i
        @name = elem['roleName']
      end
    end

  end
end
