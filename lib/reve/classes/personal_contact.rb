module Reve #:nodoc
  module Classes #:nodoc

    # Represents a single Contact
    # Attributes:
    # * contact_id ( Fixnum ) - ID of the Contact.
    # * contact_name ( String ) - Name of the belligerant Contact.
    # * in_watchlist ( Fixnum ) - Whether or not the Contact is in the watchlist.
    # * standing ( String ) - The standing of the Contact.
    class PersonalContact
      attr_reader :contact_id, :contact_name, :in_watchlist, :standing
      def initialize(elem) #:nodoc:
        @contact_id = elem['contactID'].to_i
        @contact_name = elem['contactName']
        @in_watchlist = elem['inWatchlist'] == 'True' ?  true : false
        @standing     = elem['standing'].to_i
      end
    end

  end
end
