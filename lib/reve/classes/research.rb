module Reve #:nodoc
  module Classes #:nodoc

    # A Research object holds information about Agents the Character is doing research with.
    # Attributes
    # * agent_id ( Fixnum ) - ID of the Agent
    # * skill_type_id ( Fixnum ) - Skill used for research (not the ID of the core received)
    # * research_started_at ( Time ) - Date the Character began research with the Agent
    # * points_per_day ( Float ) - Number of points generated per day
    # * remainder_points ( Float ) - Number of points remaining since last datacore purchase andor points_per_day update.
    # See Also: Character, Skill, Reve::API#research_stats
    class Research
      attr_reader :agent_id, :skill_type_id, :research_started_at, :points_per_day, :remainder_points
      def initialize(elem) #:nodoc:
        @agent_id            = elem['agentID'].to_i
        @skill_type_id       = elem['skillTypeID'].to_i
        @research_started_at = elem['researchStartDate'].to_time
        @points_per_day      = elem['pointsPerDay'].to_f
        @remainder_points    = elem['remainderPoints'].to_f
      end
    end

  end
end
