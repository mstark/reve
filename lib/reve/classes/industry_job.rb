module Reve #:nodoc
  module Classes #:nodoc

    # Used in Reve::API#personal_industry_jobs and Reve::API#corporate_industry_jobs. PersonalIndustryJob and CorporateIndustryJob
    # subclass this for more logical containment.
    # These attributes should be largely self-explanatory. There are so many of them that it's soulcrushing to document each one! (Sorry ;)
    # For further information please see: http://wiki.eve-dev.net/APIv2_Char_IndustryJobs_XML especially about +completed_status+ and +completed+
    class IndustryJob
      attr_reader :id, :assembly_line_id, :container_id, :installed_item_id, :installed_item_location_id,
                  :installed_item_quantity, :installed_item_productivity_level, :installed_item_material_level,
                  :installed_item_licensed_production_runs_remaining, :output_location_id, :installer_id, :runs,
                  :licensed_production_runs, :installed_system_id, :container_location_id, :material_multiplier,
                  :char_material_multiplier, :time_multiplier, :char_time_multiplier, :installed_item_type_id,
                  :output_type_id, :container_type_id, :installed_item_copy, :completed, :completed_successfully,
                  :installed_item_flag, :output_flag, :activity_id, :completed_status, :installed_at,
                  :begin_production_at, :end_production_at, :pause_production_time
      def initialize(elem) #:nodoc:
        @id = elem['jobID'].to_i; @assembly_line_id = elem['assemblyLineID'].to_i ; @container_id = elem['containerID'].to_i
        @installed_item_id = elem['installedItemID'].to_i ; @installed_item_location_id = elem['installedItemLocationID'].to_i
        @installed_item_quantity = elem['installedItemQuantity'].to_i
        @installed_item_productivity_level = elem['installedItemProductivityLevel'].to_i
        @installed_item_material_level = elem['installedItemMaterialLevel'].to_i
        @installed_item_licensed_production_runs_remaining = elem['installedItemLicensedProductionRunsRemaining'].to_i
        @output_location_id = elem['outputLocationID'].to_i ; @installer_id = elem['installerID'].to_i; @runs = elem['runs'].to_i
        @licensed_production_runs = elem['licensedProductionRuns'].to_i ; @installed_system_id = elem['installedInSolarSystemID'].to_i
        @container_location_id = elem['containerLocationID'].to_i ; @material_multiplier = elem['materialMultiplier'].to_f
        @char_material_multiplier = elem['charMaterialMultiplier'].to_f; @time_multiplier = elem['timeMultiplier'].to_f
        @char_time_multiplier = elem['charTimeMultiplier'].to_f ; @installed_item_type_id = elem['installedItemTypeID'].to_i
        @output_type_id = elem['outputTypeID'].to_i ; @container_type_id = elem['containerTypeID'].to_i
        @installed_item_copy = (elem['installedItemCopy'] == "1") ; @completed = (elem['completed'] == "1")
        @completed_successfully = (elem['completedSuccessfully'] == "1")
        @installed_item_flag = elem['installedItemFlag'].to_i ; @output_flag = elem['outputFlag'].to_i
        @activity_id = elem['activityID'].to_i ; @completed_status = elem['completedStatus'].to_i
        @installed_at = elem['installTime'].to_time ; @begin_production_at = elem['beginProductionTime'].to_time
        @end_production_at = elem['endProductionTime'].to_time
        @pause_production_time = elem['pauseProductionTime'].to_time
      end
    end

    class PersonalIndustryJob < IndustryJob; end
    class CorporateIndustryJob < IndustryJob; end

  end
end
