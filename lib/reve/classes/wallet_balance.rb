module Reve #:nodoc
  module Classes #:nodoc

    # Corporation or Character WalletBalance for
    # Reve::API#personal_wallet_transactions and
    # Reve::API#corporate_wallet_balance
    # Attributes
    # * account_id ( Fixnum ) - ID of the account
    # * account_key ( String ) - Account key
    # * balance ( Float ) - Balance of the wallet
    class WalletBalance
      attr_reader :account_id, :account_key, :balance
      def initialize(elem)
        @account_id  = elem['accountID'].to_i
        @account_key = elem['accountKey']
        @balance     = elem['balance'].to_f
      end
    end

  end
end
