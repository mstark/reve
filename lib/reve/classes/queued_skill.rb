module Reve #:nodoc
  module Classes #:nodoc

    # Holds the result of the Reve::API#skill_queue call.
    # Attributes
    # * queue_position ( Integer ) - The queue position of this QueuedSkill
    # * end_time ( Time ) - When the Skill is due to end
    # * start_time ( Time ) - When the Skill training was started
    # * type_id ( Fixnum ) - ID of the Skill (Refer to CCP database dump invtypes)
    # * start_sp ( Fixnum ) - How many SP did the Character have before training was started
    # * end_sp ( Fixnum ) - How many SP will the Character have after training finishes
    # * to_level ( Fixnum ) - This is the level the Skill will be at when training is completed
    # See Also: Reve::API#skill_queue
    class QueuedSkill
      attr_reader :queue_position, :end_time, :start_time, :type_id, :start_sp, :end_sp, :to_level
      def initialize(elem) #:nodoc:
        @queue_position = elem['queuePosition'].to_i
        @end_time         = elem['endTime'] == "" ? nil : elem['endTime'].to_time
        @start_time       = elem['startTime'] == "" ? nil : elem['startTime'].to_time
        @type_id          = elem['typeID'].to_i
        @start_sp         = elem['startSP'].to_i
        @end_sp           = elem['endSP'].to_i
        @to_level         = elem['level'].to_i
      end
    end

  end
end
