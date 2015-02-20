module Reve #:nodoc
  module Classes #:nodoc

    # Represents a Notification for
    # Reve::API#personal_notifications
    # Attributes
    # * id ( Fixnum ) - The unique notification ID number.
    # * notification_type_id ( Fixnum ) - The notification type indicates what has happened but not who performed the action in question nor upon whom the action was performed. See http://wiki.eve-id.net/APIv2_Char_Notifications_XML for a list of ids
    # * sender_id ( Fixnum ) - TThe ID of the entity that sent the notification.
    # * send_date ( Time ) - The ID of the entity that sent the notification.
    # * read ( Boolean ) - Whether the notification has been read in the EVE client. This does not change when you get it through the API.
    class Notification
      attr_reader :id, :name, :notification_type_id, :sender_id, :send_date, :read
      def initialize(elem) #:nodoc:
        @id = elem['notificationID'].to_i
        @notification_type_id = elem['typeID'].to_i
        @sender_id = elem['senderID'].to_i
        @send_date = elem['sentDate'].to_time
        @read = elem['read'] == '1'
      end
    end

  end
end
