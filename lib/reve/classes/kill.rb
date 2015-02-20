module Reve #:nodoc
  module Classes #:nodoc

    # Simple class to contain the information relevant to a single Kill.
    # Comprised of an array of KillLoss, an array of KillAttacker and one KillVictim
    # Attributes
    # * victim ( KillVictim ) - Instance of the KillVictim class to represent the victim of the Kill.
    # * attackers ( [KillAttacker] ) - Array of KillAttacker objects that represent the people who killed the +victim+.
    # * losses ( [KillLoss] ) - Array of KillLoss objects that represents the +victim+'s items destroyed in the Kill.
    # * system_id ( Fixnum ) - The ID of the System that the Kill took place in.
    # * id ( Fixnum ) - The ID of this specific Kill
    # * moon_id ( Fixnum | NilClass ) - The ID of the Moon that this kill happened at (due to a POS?), if any; nil otherwise.
    # See Also: KillAttacker, KillVictim, KillLoss, Reve::API#personal_kills, Reve::API#corporate_kills
    class Kill
      attr_reader :victim, :attackers, :losses
      attr_reader :system_id, :created_at, :id, :moon_id
      def initialize(elem, victim, attackers, losses) #:nodoc:
        @victim, @attackers, @losses = victim, attackers, losses
        @system_id = elem['solarSystemID'].to_i
        @created_at = elem['killTime'].to_time
        @id = elem['killID'].to_i
        @moon_id = elem['moonID'] == "0" ? nil : elem['moonID'].to_i
      end
    end

  end
end
