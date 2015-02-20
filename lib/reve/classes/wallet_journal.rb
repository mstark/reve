module Reve #:nodoc
  module Classes #:nodoc

    # Corporation or Character WalletJournal for
    # Reve::API#personal_wallet_journal and
    # Reve::API#corporate_wallet_journal
    # Attributes:
    # * date ( Time ) - Time the action occured
    # * ref_id ( Integer ) - Reference ID for this action (used with stepping through Journal Entries)
    # * reftype_id ( Integer ) - RefType id
    # * owner_name1 ( String ) - Name of the Player/Corporation/whatever that did something to owner_name2
    # * owner_name2 ( String ) - Recipient of this action (from owner_name1)
    # * owner_id1 ( Integer ) - ID of the Owner's whatever (Player/Corporation/Faction/Whatever)
    # * owner_id2 ( Integer ) - ID of the recpient (Player/Corporation/Faction/Whatever)
    # * arg_name1 ( String ) - For bounty, what caused this. (May be blank)
    # * arg_id1 ( Integer ) - ID of arg_name1
    # * amount ( Float ) - Wallet delta
    # * balance ( Float ) - New wallet balance after this action
    # * reason ( String ) - Any reason for the action. May be blank (useful in giving ISK)
    class WalletJournal
      attr_reader :date, :ref_id, :reftype_id, :owner_name1, :owner_id1, :owner_name2, :owner_id2, :arg_name1, :arg_id1, :amount, :balance, :reason, :tax_amount, :tax_receiver_id
      alias_method :id, :ref_id
      def initialize(elem) #:nodoc:
        @date        = elem['date'].to_time
        @ref_id      = elem['refID'].to_i
        @reftype_id  = elem['refTypeID'].to_i
        @owner_name1 = elem['ownerName1']
        @owner_name2 = elem['ownerName2']
        @owner_id1   = elem['ownerID1'].to_i if elem['ownerID1']
        @owner_id2   = elem['ownerID2'].to_i if elem['ownerID2']
        @arg_name1   = elem['argName1']
        @arg_id1     = elem['argID1'].to_i if elem['argID1']
        @amount      = elem['amount'].to_f
        @tax_amount      = elem['taxAmount'].to_f
        @tax_receiver_id = elem['taxReceiverID'].to_i if elem['taxReceiverID']
        @balance     = elem['balance'].to_f
        @reason      = elem['reason']
      end
    end

  end
end
