module Reve #:nodoc
  module Classes #:nodoc

    # Part of the CorporationSheet. Describes a division in the wallet
    # Attributes
    # * key ( Fixnum ) - Account key. Used for things like WalletBalance and such.
    # * description ( String ) - Description of the WalletDivision
    # See Also CorporationSheet
    class WalletDivision
      attr_reader :key, :description
      def initialize(elem) #:nodoc:
        @key = elem['accountKey'].to_i
        @description = elem['description'].split(/\n/).collect { |s| s.strip }.join(' ') # newlines to spaces
      end
    end

  end
end
