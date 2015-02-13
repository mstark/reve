module Reve #:nodoc:
  module Classes #:nodoc:

    # Represents an Alliance as it appears in the Reve::API#alliances call.
    # Attributes
    # * name ( String ) - Full Name of the Alliance
    # * short_name ( String ) - Short name (ticker) of the Alliance
    # * id ( Fixnum ) - The Alliance's Eve-Online ID
    # * executor_corp_id ( Fixnum ) - ID of the Corporation that's in charge of the Alliance
    # * member_count ( Fixnum ) - The number of members that are in the Alliance
    # * start_date ( Time ) - When the Alliance was formed.
    # * member_corporations ( [Corporation] ) - Array of the Corporation objects that belong to the Alliance.
    class Alliance
      attr_reader :name, :short_name, :id, :executor_corp_id, :member_count, :start_date
      attr_accessor :member_corporations
      def initialize(elem) #:nodoc:
        @name             = elem['name']
        @short_name       = elem['shortName']
        @id               = elem['allianceID'].to_i
        @executor_corp_id = elem['executorCorpID'].to_i
        @member_count     = elem['memberCount'].to_i
        @start_date       = elem['startDate'].to_time
        @member_corporations = []
      end
    end

  end
end
