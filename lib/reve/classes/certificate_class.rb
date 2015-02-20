module Reve #:nodoc
  module Classes #:nodoc

    # A class of Certificates.
    # Attributes:
    # * id ( Fixnum ) - ID of the CertificateClass
    # * name ( String ) - Name of the CertificateClass
    # * classes ( [ Certificate ] ) - Array of Certificate objects under this class
    class CertificateClass
      attr_reader :name, :id
      attr_accessor :certificates
      def initialize(elem) #:nodoc:
        @name = elem['className']
        @id = elem['classID'].to_i
        @certificates = []
      end
    end

  end
end
