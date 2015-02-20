require_relative 'medal'

module Reve #:nodoc
  module Classes #:nodoc

    # All of the Medals that the members of a Corporation have.
    # Attributes:
    # * character_id ( Fixnum ) - ID of the Character that has this CorporateMemberMedal
    # * reason ( String ) - Why the CorporateMemberMedal is bestowed
    # * issuer_id ( Fixnum ) - Who issued the CorporateMemberMedal
    # * status ( String ) - public or private (presumably), if this CorporateMemberMedal is public or private.
    # See Also: Medal, CharacterMedal, CharacterOtherCorporateMedal, CorporateMedal
    class CorporateMemberMedal < Medal
      attr_reader :character_id, :reason, :issuer_id, :status
      def initialize(elem) #:nodoc:
        super(elem)
        @character_id = elem["characterID"].to_i
        @reason = elem["reason"]
        @issuer_id = elem["issuerID"].to_i
        @status = elem["status"]
      end
      # If the CharacterMedal is public
      def is_public?
        @status == "public"
      end
      # If the CorporateMemberMedal is private (not public)
      def is_private?
        ! is_public?
      end
    end

  end
end
