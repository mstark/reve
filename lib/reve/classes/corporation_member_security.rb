module Reve #:nodoc
  module Classes #:nodoc

    # Holds the result of the Reve::API#corporate_member_security call.
    # Attributes
    # * members ( [CorporationMember] ) - Array of CorporationMember
    # See Also: CorporationMember, CorporateRole, CorporateTitle
    class CorporationMemberSecurity
      attr_accessor :members

      def initialize
        @members = []
      end
    end

  end
end
