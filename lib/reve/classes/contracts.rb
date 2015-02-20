module Reve #:nodoc
  module Classes #:nodoc

    #
    #Characters contracts
    #
    class Contracts
      attr_reader :contractID, :issuerID, :issuerCorpID, :assigneeID 
      attr_reader :acceptorID, :startStationID, :endStationID, :type, :status 
      attr_reader :title, :forCorp, :availability, :dateIssued, :dateExpired, :dateAccepted
      attr_reader :numDays, :dateCompleted, :price, :reward, :collateral, :buyout
      attr_reader :volume
      def initialize(elem) #:nodoc:
        @contractID       = elem['contractID'].to_i
        @issuerID         = elem['issuerID'].to_i
        @issuerCorpID     = elem['issuerCorpID'].to_i
        @assigneeID       = elem['assigneeID'].to_i
        @acceptorID       = elem['acceptorID'].to_i
        @startStationID   = elem['startStationID'].to_i
        @endStationID     = elem['endStationID'].to_i
        @type             = elem['type'].to_s
        @status           = elem['status'].to_s
        @title            = elem['title'].to_s
        @forCorp          = elem['forCorp'].to_i
        @availability     = elem['availability'].to_s
        @dateIssued       = elem['dateIssued'].to_time
        @dateExpired      = elem['dateExpired'].to_time
        @dateAccepted     = elem['dateAccepted'].to_time
        @numDays          = elem['numDays'].to_i
        @dateCompleted    = elem['dateCompleted'].to_time
        @price            = elem['price'].to_f
        @reward           = elem['reward'].to_f
        @collateral       = elem['collateral'].to_f
        @buyout           = elem['buyout'].to_f
        @volume           = elem['volume'].to_i
      end
    end

  end
end
