require_relative 'wallet_transaction'

module Reve #:nodoc
  module Classes #:nodoc

    # For Corporate WalletTransaction (WalletTransaction#transaction_for == 'corporation')
    # See WalletTransaction
    class CorporateWalletTransaction < WalletTransaction
    end

  end
end
