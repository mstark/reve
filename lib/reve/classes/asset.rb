module Reve #:nodoc
  module Classes #:nodoc

    # An item contained within an AssetContainer (ship, or container)
    # Attributes
    # * item_id ( Fixnum ) - A CCP-specific ID for the Asset/AssetContainer
    # * type_id ( Fixnum ) - Type ID of the Asset/AssetContainer. (Refer to CCP database dump invtypes)
    # * quantity ( Fixnum ) - The number of Asset/AssetContainer at this +location_id+
    # * flag ( Fixnum ) - Inventory flag, refer to http://wiki.eve-dev.net/API_Inventory_Flags (See also KillLoss's flag)
    # See Also: AssetContainer, Reve::API#corporate_assets_list, Reve::API#personal_assets_list
    class Asset
      attr_reader :item_id, :type_id, :quantity, :flag, :singleton, :rawQuantity, :xml_hash
      def initialize(elem) #:nodoc:
        @item_id = elem['itemID'].to_i
        @type_id = elem['typeID'].to_i
        @quantity = elem['quantity'].to_i
        @flag = elem['flag'].to_i
        @singleton = elem['singleton'].to_i
        @rawQuantity = elem['rawQuantity'].to_i
        # This ::Digest::SHA1 is a bit of custom code for Eve Metrics that will
        # probably find its way to all classes since it could prove handy.
        @xml_hash = ::Digest::SHA1.hexdigest elem.to_s.gsub(/\n|\r|\s/,'')
      end
    end

  end
end
