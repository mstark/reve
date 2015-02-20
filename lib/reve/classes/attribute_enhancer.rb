module Reve #:nodoc
  module Classes #:nodoc

    # Used for attribute enhancers (in-game Implants)
    # IntelligenceEnhancer, MemoryEnhancer, PerceptionEnhancer, CharismaEnhancer
    # and WillpowerEnhancer all subclass this class as this AttributeEnhancer
    # class is never used (except in a fault-case). Use the kind_of? method
    # to determine what kind of AttributeEnhancer one is dealing with.
    # Attributes
    # * name ( String ) - The name of the AttributeEnhancer (implant)
    # * value ( Fixnum ) - How much the +name+ implant boosts.
    # See Also: CharacterSheet, Reve::API#character_sheet
    class AttributeEnhancer
      attr_accessor :name, :value
      def initialize(name = "", value = 0) #:nodoc:
        @name = name
        @value = value.to_i
      end
    end
    class IntelligenceEnhancer < AttributeEnhancer; end
    class MemoryEnhancer < AttributeEnhancer; end
    class PerceptionEnhancer < AttributeEnhancer; end
    class CharismaEnhancer < AttributeEnhancer; end
    class WillpowerEnhancer < AttributeEnhancer; end

  end
end
