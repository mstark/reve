module Reve #:nodoc
  module Classes #:nodoc

    # Category of Certificates.
    # Attributes:
    # * id ( Fixnum ) - ID of the CertificateCategory
    # * name ( String ) - Name of the CertificateCategory
    # * classes ( [ CertificateClass ] ) - Array of CertificateClass objects under this Category
    class CertificateCategory
      attr_reader :name, :id
      attr_accessor :classes
      def initialize(elem) #:nodoc:
        @name = elem['categoryName']
        @id = elem['categoryID'].to_i
        @classes = []
      end
    end

  end
end
