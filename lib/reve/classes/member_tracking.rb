module Reve #:nodoc
  module Classes #:nodoc

    # Holds the result of the Reve::API#member_tracking call for big brother.
    # * character_id ( Fixnum ) - ID of the Character
    # * character_name ( String ) - Name of the Character
    # * start_time ( Time ) - When the Character joined the Corporation
    # * base_id ( Fixnum ) - ID of the Station (Starbase too?) where the Character calls home
    # * base ( String ) - Name of the Station (Starbase?) where the Character calls home
    # * title ( String ) - Title of the Character
    # * logon_time ( Time | NilClass ) - When the Character last logged on (or nil for non-CEOs)
    # * logoff_time ( Time | NilClass ) - When the Character last logged off (or nil for non-CEOs)
    # * location_id ( Fixnum ) - ID of the Station (Starbase too?) where the Character last/currently is
    # * location ( String ) - Name of the Station (Starbase?) where the Character last/currently is
    # * ship_type_id ( Fixnum ) - Type ID of the ship the Character is flying. (Refer to CCP database dump invtypes)
    # * ship_type ( String ) - Name of the type of ship the Character is flying
    # * roles ( String ) - List of roles for the Character
    # * grantable_roles ( String ) - List of grantable roles for the Character
    # See Also: Reve::API#member_tracking
    class MemberTracking
      attr_reader :character_id, :character_name, :start_time, :base_id, :base, :title, :logon_time, :logoff_time,
                  :location_id, :location, :ship_type_id, :ship_type, :roles, :grantable_roles
      def initialize(elem) #:nodoc:
        @character_id    = elem['characterID'].to_i
        @character_name  = elem['name']
        @start_time      = elem['startDateTime'].to_time
        @base_id         = elem['baseID'].to_i
        @base            = elem['base']
        @title           = elem['title']
        @logon_time      = elem['logonDateTime'].to_time rescue nil # can be nil for non CEOs
        @logoff_time     = elem['logoffDateTime'].to_time rescue nil # Can be nil for non CEOs
        @location_id     = elem['locationID']
        @location        = elem['location']
        @ship_type_id    = elem['shipTypeID'].to_i
        @ship_type       = elem['shipType']
        @roles           = elem['roles']
        @grantable_roles = elem['grantableRoles']
      end
    end

  end
end
