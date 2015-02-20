module Reve #:nodoc
  module Classes #:nodoc

    # Part of the CorporationMemberSecurity; represnets a Corporation's member
    # All of these values are internal to CCP; +shape_1+ matches with +color_1+ and so on.
    # Attributes
    # * name ( String ) - Name of the Character
    # * id ( Fixnum ) - ID of the Character
    # * roles ( [CorporateRole] ) - Array of Roles
    class CorporationMember
      attr_accessor :roles, :grantableRoles, :rolesAtHQ, :grantableRolesAtHQ, :rolesAtBase
      attr_accessor :grantableRolesAtBase, :rolesAtOther, :grantableRolesAtOther, :titles
      attr_accessor :id, :name

      alias_method :roles_at_hq,    :rolesAtHQ
      alias_method :grantable_roles_at_hq,    :grantableRolesAtHQ
      alias_method :roles_at_base,  :rolesAtBase
      alias_method :grantable_roles_at_base,  :grantableRolesAtBase
      alias_method :roles_at_other, :rolesAtOther
      alias_method :grantable_roles_at_other, :grantableRolesAtOther

      def initialize(elem) #:nodoc:
        @id = elem['characterID'].to_i
        @name = elem['name']

        @roles = []
        @grantableRoles = []
        @rolesAtHQ = []
        @grantableRolesAtHQ = []
        @rolesAtBase = []
        @grantableRolesAtBase = []
        @rolesAtOther = []
        @grantableRolesAtOther = []
        @titles = []
      end
    end

  end
end
