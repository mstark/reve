module Reve #:nodoc
  module Classes #:nodoc

    class StarbaseCombatSettings
      attr_reader :on_standings_drop, :on_status_drop, :on_aggression, :on_corporation_war
      def initialize(elem) #:nodoc:
        @on_standings_drop  = elem['onStandingDrop'].attribute("standing").value.to_i
        @on_status_drop     = (elem['onStatusDrop'].attribute('enabled').value == '1' ? elem['onStatusDrop'].attribute('standing').value.to_i : false)
        @on_aggression      = elem['onAggression'].attribute('enabled').value == '1'
        @on_corporation_war = elem['onCorporationWar'].attribute('enabled').value == '1'
      end
    end

  end
end
