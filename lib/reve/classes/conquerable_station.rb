module Reve #:nodoc
  module Classes #:nodoc

    # Holds the result of the Reve::API#conqurable_stations call.
    # Attributes
    # * id ( Fixnum ) - ID of the ConqurableStation
    # * name ( String ) - Name of the ConqurableStation
    # * type_id ( Fixnum ) - What kind of ConqurableStation Station it is (Refer to CCP database dump invtypes).
    # * system_id ( Fixnum ) - ID of the system where the ConqurableStation is located.
    # * corporation_id ( Fixnum ) - ID of the Corporation that owns the ConqurableStation
    # * corporation_name ( String ) - Name of the Corporation that owns the ConqurableStation.
    # See Also: Sovereignty, Reve::API#conqurable_stations, Reve::API#sovereignty, Reve::API#corporation_sheet, CorporationSheet
    class ConqurableStation
      attr_reader :id, :name, :type_id, :system_id, :corporation_id, :corporation_name
      def initialize(elem) #:nodoc:
        @id = elem['stationID'].to_i
        @name = elem['stationName']
        @type_id = elem['stationTypeID'].to_i
        @corporation_id = elem['corporationID'].to_i
        @corporation_name = elem['corporationName']
        @system_id = elem['solarSystemID'].to_i
      end
    end

    class ConquerableStation < ConqurableStation; end

  end
end
