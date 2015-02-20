module Reve #:nodoc
  module Classes #:nodoc

    # Represents a MailingList for
    # Reve::API#personal_mailing_lists
    # Attributes
    # * id ( Fixnum ) - ID of the MailingList (use this in the Reve::API#mail_messages call)
    # * name ( String ) - Name of the MailingList
    class MailingList
      attr_reader :id, :name
      def initialize(elem) #:nodoc:
        @id = elem['listID'].to_i
        @name = elem['displayName']
      end
    end

  end
end
