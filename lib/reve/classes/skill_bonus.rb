module Reve #:nodoc
  module Classes #:nodoc

    # A SkillBonus, for SkillTree and Reve::API#skill_tree.
    # Bear in mind that "SkillBonus" doesn't always mean anything useful or beneficial
    # * type ( String ) - Name of the bonus
    # * value ( String ) - Value of the bonus. This is may be Fixnum or Float or Boolean but is left as a String
    # See Also: SkillTree, Reve::API#skill_tree
    class SkillBonus
      attr_reader :type, :value
      def initialize(elem) #:nodoc:
        @type = elem['bonusType']
        @value = elem['bonusValue']
      end
    end

  end
end
