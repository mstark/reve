require_relative 'wallet_transaction'

module Reve #:nodoc
  module Classes #:nodoc

    # For Personal WalletTransaction (WalletTransaction#transaction_for == 'personal')
    # See WalletTransaction
    class PersonalWalletTransaction < WalletTransaction
    end

  end
end
