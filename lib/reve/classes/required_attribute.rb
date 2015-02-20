module Reve #:nodoc
  module Classes #:nodoc

    # A Skill has a RequiredAttribute, either a PrimaryAttribute or SecondaryAttribute, which both derrive from this.
    # Attributes
    # * name ( String ) - Name of the required Attribute
    # See Also: PrimaryAttribute, SecondaryAttribute, Skill, Reve::API#skill_tree
    class RequiredAttribute
      attr_reader :name
      def initialize(attrib) #:nodoc:
        @name = attrib
      end
    end

  end
end
