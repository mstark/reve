module Reve #:nodoc
  module Classes #:nodoc

    # A model to represent losses from being killed.
    # Attributes
    # * type_id ( Fixnum ) - Type ID of the KillLoss. (Refer to CCP database dump invtypes)
    # * flag ( Fixnum ) - A flag to denoe some special qualities of the KillLoss such as where it was mounted or if it was in a container. Refer to http://wiki.eve-dev.net/API_Inventory_Flags
    # * quantity_dropped ( Fixnum ) - The number of +type_id+ that were dropped for looting - e.g., not destroyed.
    # * quantity_destroyed ( Fixnum ) - The number of +type_id+ that were destroyed in the Kill.
    # * contained_losses ( [KillLoss] ) - If the KillLoss was a container (refer to +type_id+) then this array will be populated with a list of KillLoss objects that were inside the container.
    # See Also: Kill, KillAttacker, KillVictim, Reve::API#personal_kills, Reve::API#corporate_kills
    class KillLoss
      attr_reader :type_id, :flag, :quantity_dropped, :quantity_destroyed
      attr_accessor :contained_losses
      def initialize(elem)
        @type_id = elem['typeID'].to_i
        @flag = elem['flag'].to_i
        @quantity_dropped = elem['qtyDropped'].to_i
        @quantity_destroyed = elem['qtyDestroyed'].to_i
        @contained_losses = []
      end
    end

  end
end
