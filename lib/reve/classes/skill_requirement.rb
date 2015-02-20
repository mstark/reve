module Reve #:nodoc
  module Classes #:nodoc

    # A SkillRequirement, for SkillTree and Reve::API#skill_tree
    # Attributes
    # * type_id ( Fixnum ) - ID of the Skill that is the SkillRequirement (Refer to CCP database dump invtypes)
    # * level ( Fixnum ) - What level of the Skill is required
    # See Also: SkillTree, Reve::API#skill_tree
    class SkillRequirement
      attr_reader :type_id, :level
      alias_method :id, :type_id
      def initialize(elem)
        @type_id = elem['typeID'].to_i
        @level = elem['skillLevel'].to_i
      end
    end

  end
end
