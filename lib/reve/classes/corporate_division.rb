module Reve #:nodoc
  module Classes #:nodoc

    # Part of the CorporationSheet. Describes a division of the Corporation
    # Attributes
    # * key ( Fixnum ) - Account key.
    # * description ( String ) - Description of the CorporateDivision
    # See Also CorporationSheet
    class CorporateDivision
      attr_reader :key, :description
      def initialize(elem) #:nodoc:
        @key = elem['accountKey'].to_i
        @description = elem['description'].split(/\n/).collect { |s| s.strip }.join(' ') # newlines to spaces
      end
    end

  end
end
