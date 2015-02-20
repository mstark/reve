module Reve #:nodoc
  module Classes #:nodoc

    # Holds the result of the Reve::API#skill_in_training call.
    # Note: When a Character finishes training the API will not be updated until the Character next logs into the game.
    # Attributes
    # * tranquility_time ( Time ) - The current time on Tranquility
    # * end_time ( Time ) - When the Skill is due to end
    # * start_time ( Time ) - When the Skill training was started
    # * type_id ( Fixnum ) - ID of the Skill (Refer to CCP database dump invtypes)
    # * start_sp ( Fixnum ) - How many SP did the Character have before training was started
    # * end_sp ( Fixnum ) - How many SP will the Character have after training finishes
    # * to_level ( Fixnum ) - This is the level the Skill will be at when training is completed
    # * skill_in_training ( Boolean ) - Is there actually a skill in training? (Check this first before doing anything)
    # See Also: CharacterSheet, Reve::API#skill_in_training
    class SkillInTraining
      attr_reader :tranquility_time, :end_time, :start_time, :type_id, :start_sp, :end_sp, :to_level, :skill_in_training
      def initialize(elem) #:nodoc:
        @tranquility_time = elem['currentTQTime'].to_time
        @end_time         = elem['trainingEndTime'].to_time
        @start_time       = elem['trainingStartTime'].to_time
        @type_id          = elem['trainingTypeID'].to_i
        @start_sp         = elem['trainingStartSP'].to_i
        @end_sp           = elem['trainingDestinationSP'].to_i
        @to_level         = elem['trainingToLevel'].to_i
        @skill_in_training= elem['skillInTraining'] == '1'
      end
    end

  end
end
