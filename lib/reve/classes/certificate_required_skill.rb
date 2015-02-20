module Reve #:nodoc
  module Classes #:nodoc

    class CertificateRequiredSkill
      attr_reader :id, :level
      def initialize(elem)
        @id = elem["typeID"].to_i
        @level = elem["level"].to_i
      end
    end

  end
end
