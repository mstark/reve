module Reve #:nodoc
  module Classes #:nodoc

    # Holds the result of the Reve::API#character_sheet call.
    # This has all of the stuff that appears in the in-game 'character sheet'
    # screen.
    # The skills array is a Skill list (no name is stored in it)
    # The enhancers array is an AttributeEnhancer derrived list
    # Attributes
    # * name ( String ) - Name of the Character
    # * race ( String ) - Race of the Character
    # * gender ( String ) - Gender of the Character
    # * id ( Fixnum ) - ID of the Character
    # * corporation_name ( String ) - Name of the Corporation the Character is in
    # * corporation_id ( Fixnum ) - ID of the Corporation the Character is in
    # * balance ( Float ) - How much ISK the Character has
    # * intelligence ( Fixnum ) - Character's Intelligence level
    # * memory ( Fixnum ) -
    # * charisma ( Fixnum ) -
    # * perception ( Fixnum ) -
    # * willpower ( Fixnum ) -
    # * skills ( [Skill] ) - An Array of Skill objects that the Character has trained.
    # * enhancers ( [AttributeEnhancer] ) - An Array of any implants (AttributeEnhancer) the Character has in its head.
    # See Also: Reve::API#character_sheet, AttributeEnhancer (and subclasses), Skill
    class CharacterSheet
      attr_accessor :name, :race, :bloodline, :gender, :id, :corporation_name, :corporation_id, :balance
      attr_accessor :intelligence, :memory, :charisma, :perception, :willpower, :clone_name, :clone_skill_points
      attr_accessor :skills, :enhancers, :roles, :certificate_ids, :corporate_titles, :dob, :ancestry
      attr_accessor :corporationRolesAtHQ, :corporationRoles, :corporationRolesAtBase, :corporationRolesAtOther
      alias_method :corporate_roles_at_hq,    :corporationRolesAtHQ
      alias_method :corporate_roles,          :corporationRoles
      alias_method :corporate_roles_at_base,  :corporationRolesAtBase
      alias_method :corporate_roles_at_other, :corporationRolesAtOther
      def initialize #:nodoc:
        @skills = []
        @enhancers = []
        @roles = []
        @certificate_ids = []
        @corporate_titles = []
        @corporationRolesAtHQ = []
        @corporationRoles = []
        @corporationRolesAtBase = []
        @corporationRolesAtOther = []
      end
      def clonename=(n) #:nodoc:
        @clone_name = n
      end
      def cloneskillpoints=(i) #:nodoc:
        @clone_skill_points = i
      end
      def characterid=(i) #:nodoc:
        @id = i.to_i
      end
      def corporationname=(i) #:nodoc:
        @corporation_name = i
      end
      def corporationid=(i) #:nodoc:
        @corporation_id = i.to_i
      end
    end

  end
end
