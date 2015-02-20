module Reve #:nodoc
  module Classes #:nodoc

    # Represents a MailMessage for
    # Reve::API#personal_mail_messages
    # Attributes
    # * id ( Fixnum ) - The unique message ID number.
    # * sender_id ( Fixnum ) - The character ID of the message originator. (use Reve::API#character_name to get their names)
    # * send_date ( Time ) - The date the message was sent.
    # * title ( String ) - The title of the message
    # * to_corp_or_alliance_id ( Fixnum ) - The ID of a corporation/alliance that the message was sent to.
    # * to_character_ids ( [Fixnum] ) - Array of character IDs of the characters that received the message.
    # * to_list_ids ( [Fixnum] ) - Array of mailing lists that the mail was sent to. (use Reve::API#personal_mailing_lists to get their names)
    class MailMessage
      attr_reader :id, :name, :sender_id, :send_date, :title, :to_corp_or_alliance_id, :to_character_ids, :to_list_ids
      # Getting the text of a mail message requires a separate Eve API call
      # Done in Reve::API#personal_mail_bodies
      attr_accessor :body
      def initialize(elem) #:nodoc:
        @id = elem['messageID'].to_i
        @sender_id = elem['senderID'].to_i
        @send_date = elem['sentDate'].to_time
        @title = elem['title']
        @to_corp_or_alliance_id = elem['toCorpOrAllianceID'] == '' ? nil : elem['toCorpOrAllianceID'].to_i
        @to_character_ids = elem['toCharacterIDs'] == '' ? nil : elem['toCharacterIDs'].split(',').collect {|id| id.to_i }
        @to_list_ids = elem['toListID'] == '' ? nil : elem['toListID'].split(',').collect {|id| id.to_i }
      end
    end

  end
end
