module Reve #:nodoc
  module Classes #:nodoc

    # A Skill is used in the CharacterSheet for Reve::API#character_sheet call.
    # Attributes
    # * id ( Fixnum ) - Type ID of the Skill. (Refer to CCP database dump invtypes)
    # * skillpoints ( Fixnum ) - Number of skill points invested in this skill
    # * level ( Fixnum ) - Level of the Skill
    # See Also: CharacterSheet, Reve::API#character_sheet
    class Skill
      attr_accessor :id, :unpublished, :skillpoints, :level
      def initialize(elem) #:nodoc:
        @id          = elem['typeID'].to_i
        @skillpoints = elem['skillpoints'].to_i
        @level       = elem['level'].to_i
      end
    end

  end
end
