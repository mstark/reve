require_relative 'character_medal'

module Reve #:nodoc
  module Classes #:nodoc

    # Composed in CharacterMedals. Issued by the Corporation the Character is a member
    # Attributes:
    # * corporation_id ( Fixnum ) - ID of the Corporation that issued the CharacterOtherCorporateMedal
    # * title ( String ) - The title this CharacterOtherCorporateMedal bestows on the Character
    # * description ( String ) - Description of the CharacterOtherCorporateMedal.
    # See Also: Medal, CharacterMedal, CorporateMemberMedal, CorporateMedal
    class CharacterOtherCorporateMedal < CharacterMedal
      attr_reader :corporation_id, :title, :description
      def initialize(elem) #:nodoc:
        super(elem)
        @corporation_id = elem["corporationID"].to_i
        @title = elem["title"]
        @description = elem["description"]
      end
    end

  end
end
