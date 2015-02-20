module Reve #:nodoc
  module Classes #:nodoc

    # Certificate tree container. This looks like:
    # [CertificateCategory]
    #   [CertificateClass]
    #     [Certificate]
    #       [CertificateRequiredSkill]
    #       [CertificateRequiredCertificate]
    class CertificateTree
      attr_accessor :categories
      def initialize(categories = []) #:nodoc:
        @categories = categories
      end
    end

  end
end
