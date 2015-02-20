module Reve #:nodoc
  module Classes #:nodoc

    class Certificate
      attr_reader :id, :grade, :corporation_id, :description
      attr_accessor :required_skills, :required_certificates
      def initialize(elem)
        @id = elem['certificateID'].to_i
        @grade = elem['grade'].to_i
        @corporation_id = elem['corporationID'].to_i
        @description = elem['description']
        @required_certificates = []
        @required_skills = []
      end
    end

  end
end
