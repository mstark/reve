module Reve #:nodoc
  module Classes #:nodoc

    # Corporation or Character WalletTransaction for
    # Reve::API#personal_wallet_transactions and
    # Reve::API#corporate_wallet_transactions
    # Attributes
    # * created_at ( Time ) - When was the WalletTransaction created?
    # * id ( Fixnum ) - CCP's ID of the WalletTransaction. Note: This is not guaranteed to be unique. It may be best to create your own unique ID
    # * quantity ( Fixnum ) - Number of +type_id+ transacted
    # * type_name ( String ) - Name of the transacted thing
    # * price ( Float) - Price of the transacted thing
    # * client_id ( Fixnum ) - ID of the client
    # * client_name ( String ) - Name of the client
    # * character_id ( Fixnum ) - ID of the Character
    # * station_id ( Fixnum ) - ID of the Station where the WalletTransaction took place
    # * station_name ( String ) - Name of the Station where the WalletTransaction took place
    # * type ( String ) - Not sure?
    # * transaction_for ( String ) - This is corporate or personal, mirrors the subclasses.
    class WalletTransaction
      attr_reader :created_at, :id, :quantity, :type_name, :type_id, :price,
                  :client_id, :client_name, :character_id, :station_id, :station_name, :type,
                  :transaction_for, :character_name
      def initialize(elem) #:nodoc:
        @created_at       = elem['transactionDateTime'].to_time
        @id               = elem['transactionID'].to_i
        @quantity         = elem['quantity'].to_i
        @type_name        = elem['typeName']
        @type_id          = elem['typeID'].to_i
        @price            = elem['price'].to_f
        @client_id        = elem['clientID'].to_i if elem['clientID']
        @client_name      = elem['clientName']
        @character_name   = elem['characterName']
        @station_id       = elem['stationID'].to_i
        @station_name     = elem['stationName']
        @character_id     = elem['characterID'].to_i if elem['characterID'] && elem['characterID'] != '0'
        @type             = elem['transactionType']
        @transaction_for  = elem['transactionFor'] # This is corporate or personal, mirrors the subclasses.
      end
    end

  end
end
