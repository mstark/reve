module Reve #:nodoc
  module Classes #:nodoc

    # Represents a AccountStatus for
    # Reve::API#account_status
    # Attributes
    # * user_id ( Fixnum ) - The account's userID
    # * paid_until ( Time ) - DateTime until when the account is still active.
    # * created_at ( Time ) - DateTime when the account was created.
    # * logon_count ( Fixnum ) - The amount of times the User logged in.
    # * logon_minutes ( Fixnum ) - The amount of minutes the user was logged in.
    # GTC buy offers not yet inplemented
    class AccountStatus
      attr_reader :user_id, :paid_until, :created_at, :logon_count, :logon_minutes
      def initialize(elem) #:nodoc:
        @user_id = (elem/'userID').inner_html.to_i
        @paid_until = Time.parse((elem/'paidUntil').inner_html)
        @created_at = Time.parse((elem/'createDate').inner_html)
        @logon_count = (elem/'logonCount').inner_html.to_i
        @logon_minutes = (elem/'logonMinutes').inner_html.to_i
      end
    end

  end
end
