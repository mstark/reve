module Reve #:nodoc
  module Classes #:nodoc

    # Represents a CharacterInfo for
    # Reve::API#character_info
    # Basic Attributes
    # * id ( Fixnum ) - ID of the Character
    # * name ( String ) - Name of the Character
    # * race ( String ) - Race of the Character
    # * bloodline ( String ) - Bloodline of the Character
    # * corporation_id ( Fixnum ) - ID of the Corporation the Character is in
    # * corporation_name ( String ) - Name of the Corporation the Character is in
    # * corporation_date ( Time ) - Date the Character joined his Corporation
    # * alliance_id ( Fixnum | NilClass ) - The ID of the Alliance the Character is in, if any. Will be nil unless the victim was in an Alliance
    # * alliance_name ( String  | NilClass ) - Name of the Alliance the Character is in, if any.
    # * alliance_date ( Time | NilClass ) - Date the Character's Corporations joined the Alliance.
    # * security_status ( Float ) - Security status of the Character
    # Limited Attributes
    # * skillpoints ( Fixnum ) - The amount of Skillpoints
    # * skill_training_ends ( Time )-
    # * ship_name ( String ) -
    # * ship_type_id ( Fixnum ) -
    # * ship_type_name ( String ) -
    # Full Attributes
    # * last_known_location ( String ) -
    # * account_balance ( Float )
    class CharacterInfo
      attr_reader :id, :name, :race, :bloodline, :corporation_id, :corporation_name, :corporation_date, :alliance_id, :alliance_name, :alliance_date, :security_status
      attr_reader :skillpoints, :skill_training_ends, :ship_name, :ship_type_id, :ship_type_name
      attr_reader :last_known_location, :account_balance

      def initialize(elem) #:nodoc:
        @id = (elem/'characterID').inner_html.to_i
        @name = (elem/'characterName').inner_html
        @dob = (elem/'DoB').inner_html
        @race = (elem/'race').inner_html
        @bloodline = (elem/'bloodline').inner_html
        @ancestry = (elem/'ancestry').inner_html
        @corporation_id = (elem/'corporationID').inner_html.to_i
        @corporation_name = (elem/'corporation').inner_html
        @corporation_date = Time.parse((elem/'corporationDate').inner_html)
        @alliance_id = (elem/'allianceID').inner_html.to_i
        @alliance_name = (elem/'alliance').inner_html
        @alliance_date = (elem/'alliancenDate').inner_html == "" ? nil : Time.parse((elem/'alliancenDate').inner_html)
        @security_status  = (elem/'securityStatus').inner_html.to_f
        @skillpoints = (elem/'skillPoints').inner_html == "" ? nil : (elem/'skillPoints').inner_html.to_i
        @skill_training_ends = (elem/'nextTrainingEnds').inner_html == "" ? nil : Time.parse((elem/'nextTrainingEnds').inner_html)
        @ship_name = (elem/'shipName').inner_html == "" ? nil : (elem/'shipName').inner_html
        @ship_type_id = (elem/'shipTypeID').inner_html == "" ? nil : (elem/'shipTypeID').inner_html.to_i
        @ship_type_name = (elem/'shipTypeName').inner_html == "" ? nil : (elem/'shipTypeName').inner_html
        @last_known_location = (elem/'lastKnownLocation').inner_html == "" ? nil : (elem/'lastKnownLocation').inner_html
        @account_balance = (elem/'accountBalance').inner_html == "" ? nil : (elem/'accountBalance').inner_html.to_f
      end


      def type
        if self.account_balance
          return :full
        elsif self.skillpoints
          return :limited
        else
          return :basic
        end
      end
    end
  end
end
