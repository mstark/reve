module Reve #:nodoc
  module Classes #:nodoc

    # Represents a Character for the Reve::API#characters, Reve::API#character_name and Reve::API#character_id calls.
    # Attributes
    # * name ( String ) - Name of the Character
    # * id ( Fixnum ) - ID of the Character (use this for Reve::API method calls)
    # * corporation_name ( String | NilClass ) - Name of the Corporation the Character belongs to. Nil if being used for Reve::API#character_name or Reve::API#character_id
    # * corporation_id ( Fixnum | NilClass ) - ID of the Corporation the Character belongs to. Nil if being used for Reve::API#character_name or Reve::API#character_id
    # See Also: Reve::API
    class Character
      attr_reader :name, :id, :corporation_name, :corporation_id
      def initialize(elem) #:nodoc:
        @id               = elem['characterID'].to_i
        @name             = elem['name']
        @corporation_name = elem['corporationName']
        @corporation_id   = elem['corporationID'].to_i
      end
    end

  end
end
