module Reve #:nodoc
  module Classes #:nodoc

    class StarbaseGeneralSettings
      attr_reader :usage_flags, :deploy_flags, :allow_corporation_members,
                  :allow_alliance_members, :claim_sovereignty
      def initialize(elem) #:nodoc:
        @usage_flags                = elem['usageFlags'].to_i
        @deploy_flags               = elem['deployFlags'].to_i
        @allow_corporation_members  = elem['allowCorporationMembers'] == '1'
        @allow_alliance_members     = elem['allowAllianceMembers'] == '1'
        @claim_sovereignty          = elem['claimSovereignty'] == '1'
      end
    end

  end
end
