require_relative 'medal'

module Reve #:nodoc
  module Classes #:nodoc

    # The medals a Corporation can give out.
    # Attributes
    # * title ( String ) - Title that this CorporateMedal gives
    # * creator_id ( Fixnum ) - Who created the CorporateMedal
    # * description ( String ) Description of the CorporateMedal
    # * created_at ( Time ) - When the CorporateMedal was created.
    # See Also: Medal, CharacterMedal, CharacterOtherCorporateMedal, CorporateMemberMedal,
    class CorporateMedal < Medal
      attr_reader :title, :creator_id, :description, :created_at
      def initialize(elem) #:nodoc:
        super(elem)
        @title = elem["title"]
        @creator_id = elem["creatorID"].to_i
        @description = elem["description"]
        @created_at = elem["created"].to_time
      end
    end

  end
end
