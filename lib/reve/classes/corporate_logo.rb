module Reve #:nodoc
  module Classes #:nodoc

    # Part of the CorporationSheet; represnets a Corporation's in-game logo
    # All of these values are internal to CCP; +shape_1+ matches with +color_1+ and so on.
    # Attributes
    # * graphic_id ( Fixnum )
    # * shape_1 ( Fixnum )
    # * shape_2 ( Fixnum )
    # * shape_3 ( Fixnum )
    # * color_1 ( Fixnum )
    # * color_2 ( Fixnum )
    # * color_3 ( Fixnum )
    class CorporateLogo
      attr_reader :graphic_id, :shape_1, :shape_2, :shape_3, :color_1, :color_2, :color_3
      def initialize(elem) #:nodoc:
        @graphic_id = elem['graphicID'].to_i
        @shape_1    = elem['shape1'].to_i
        @shape_2    = elem['shape2'].to_i
        @shape_3    = elem['shape3'].to_i
        @color_1    = elem['color1'].to_i
        @color_2    = elem['color2'].to_i
        @color_3    = elem['color3'].to_i
      end
    end

  end
end
