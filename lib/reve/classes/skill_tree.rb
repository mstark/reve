module Reve #:nodoc
  module Classes #:nodoc

    # Holds the result of the Reve::API#skill_tree call. Currently this is not
    # nested based on group_id in each individual skill.
    # Attributes
    # * name ( String ) - Name of a Skill
    # * type_id ( Fixnum ) - ID of the Skill (Refer to CCP database dump invtypes)
    # * group_id ( Fixnum ) - Group ID of the Skill (Refer to CCP database dump invgroups)
    # * description ( Skill ) - Description of the Skill
    # * rank ( Fixnum ) - Rank of the skill
    # * attribs ( [RequiredAttribute] ) - Two-element array with the PrimaryAttribute and SecondaryAttribute for the Skill
    # * skills ( [SkillTree] ) - Nested Skills under this group. NOT USED
    # * bonuses ( [SkillBonus] ) - Bonuses given by this Skill
    # See Also: SkillBonus, RequiredAttribute, Reve::API#skill_tree
    class SkillTree
      attr_reader :name, :type_id, :group_id, :description, :rank, :attribs, :required_skills, :bonuses
      def initialize(name, typeid, groupid, desc, rank, attribs = [], skills = [], bonuses = []) #:nodoc:
        @name = name
        @type_id = typeid.to_i
        @group_id = groupid.to_i
        @rank = rank.to_i
        @attribs = attribs
        @required_skills = skills
        @bonuses = bonuses
        # turn multiline literals (embedded \n and lot of white space) into one
        # line!
        @description = desc.split(/\n/).collect { |s| s.strip }.join(' ')
      end
    end

  end
end
