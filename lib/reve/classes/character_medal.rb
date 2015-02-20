require_relative 'medal'

module Reve #:nodoc
  module Classes #:nodoc

    # Composed in CharacterMedals. Issued by the Corporation the Character is a member
    # Attributes:
    # * reason ( String ) - Why the CharacterMedal was issued
    # * issuer_id ( Fixnum ) - Who issued the CharacterMedal
    # * status ( String ) - public or private (presumably), if this CharacterMedal is public or private.
    # See Also: Medal, CharacterOtherCorporateMedal, CorporateMemberMedal, CorporateMedal
    class CharacterMedal < Medal
      attr_reader :reason, :issuer_id, :status
      def initialize(elem) #:nodoc:
        super(elem)
        @reason = elem["reason"]
        @issuer_id = elem["issuerID"].to_i
        @status = elem["status"]
      end
      # If the CharacterMedal is public
      def is_public?
        @status == "public"
      end
      # If the CharacterMedal is private (not public)
      def is_private?
        ! is_public?
      end
    end

  end
end
