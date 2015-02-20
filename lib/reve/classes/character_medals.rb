module Reve #:nodoc
  module Classes #:nodoc

    # Container for the CharacterMedal since there's two kinds returned in XML
    # Attributes:
    # * current_corporation ( [ CharacterMedal ] ) - Array of CharacterMedal for the Corporation this Character is currently in
    # * other_corporation ( [ CharacterOtherCorporateMedal ] ) - Array of CharacterOtherCorporateMedal from other Corporations
    # See also: Medal, CharacterMedal, Reve::API#character_medals
    class CharacterMedals
      attr_reader :current_corporation, :other_corporation
      def initialize(current, other)
        @current_corporation = current
        @other_corporation = other
      end
    end

  end
end
