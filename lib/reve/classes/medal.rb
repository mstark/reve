module Reve #:nodoc
  module Classes #:nodoc

    # Parent class for Medals
    # Attributes:
    # * id ( Fixnum ) - ID for the Medal
    # * issued_at ( Time ) - When the Medal was issued (Note: Not valid/present on the CorporateMedal)
    # See Also: CharacterMedal, CharacterOtherCorporateMedal, CorporateMemberMedal, CorporateMedal
    class Medal
      attr_reader :id, :issued_at
      def initialize(elem) #:nodoc:
        @id = elem["medalID"].to_i
        @issued_at = elem["issued"].to_time
      end
    end

  end
end
