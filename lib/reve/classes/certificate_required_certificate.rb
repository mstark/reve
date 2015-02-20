module Reve #:nodoc
  module Classes #:nodoc

    class CertificateRequiredCertificate
      attr_reader :id, :grade
      def initialize(elem)
        @id = elem["certificateID"].to_i
        @grade = elem["grade"].to_i
      end
    end

  end
end
