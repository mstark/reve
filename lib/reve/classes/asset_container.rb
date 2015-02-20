module Reve #:nodoc
  module Classes #:nodoc

    # A container or singleton (unpackaged thing).
    # Attributes
    # * item_id ( Fixnum ) - A CCP-specific ID for the Asset/AssetContainer
    # * location_id ( Fixnum ) - The ID of the Station (or POS?) that the Asset/AssetContainer is at.
    # * type_id ( Fixnum ) - Type ID of the Asset/AssetContainer. (Refer to CCP database dump invtypes)
    # * quantity ( Fixnum ) - The number of Asset/AssetContainer at this +location_id+
    # * flag ( Fixnum ) - Inventory flag, refer to http://wiki.eve-dev.net/API_Inventory_Flags (See also KillLoss's flag)
    # * singleton ( Boolean ) - True if the Asset/AssetContainer is not packaged up.
    # * assets ( [Asset] ) - A list of Asset objects that are contained in this AssetContainer.
    # See Also: Asset, Reve::API#corporate_assets_list, Reve::API#personal_assets_list
    class AssetContainer
      attr_reader :item_id, :location_id, :type_id, :quantity, :flag, :singleton, :rawQuantity, :xml_hash
      attr_accessor :assets
      def initialize(elem)
        @item_id = elem['itemID'].to_i
        @location_id = elem['locationID'].to_i
        @type_id = elem['typeID'].to_i
        @quantity = elem['quantity'].to_i
        @flag = elem['flag'].to_i
        @singleton = elem['singleton'] == "1"
        @rawQuantity = elem['rawQuantity'].to_i
        @assets = []
        # This ::Digest::SHA1 is a bit of custom code for Eve Metrics that will
        # probably find its way to all classes since it could prove handy.
        @xml_hash = ::Digest::SHA1.hexdigest elem.to_s.gsub(/\n|\r|\s/,'')
      end
    end

  end
end
