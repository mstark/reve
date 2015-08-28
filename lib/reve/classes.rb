#--
# Code copyright Lisa Seelye, 2007-2008. www.crudvision.com
# Reve is not licensed for commercial use. For other uses there are no
# restrictions.
#
# The author is not adverse to tokens of appreciation in the form of Eve ISK,
# ships, and feedback. Please use
# http://www.crudvision.com/reve-ruby-eve-online-api-library/ to provide
# feedback
#++
require_relative 'classes/alliance'
require_relative 'classes/name'
require_relative 'classes/corporation'
require_relative 'classes/eve_faction_war_stat'
require_relative 'classes/personal_faction_war_particpant'
require_relative 'classes/corporate_faction_war_particpant'
require_relative 'classes/factionwide_faction_war_particpant'
require_relative 'classes/faction_war'
require_relative 'classes/personal_contact'
require_relative 'classes/corporate_contact'
require_relative 'classes/alliance_contact'
require_relative 'classes/faction_war_system_status'
require_relative 'classes/character_faction_kills'
require_relative 'classes/corporation_faction_kills'
require_relative 'classes/faction_kills'
require_relative 'classes/character_faction_victory_points'
require_relative 'classes/corporation_faction_victory_points'
require_relative 'classes/faction_victory_points'
require_relative 'classes/faction_war_top_stats'
require_relative 'classes/research'
require_relative 'classes/contracts'
require_relative 'classes/primary_attribute'
require_relative 'classes/secondary_attribute'
require_relative 'classes/kill_victim'
require_relative 'classes/kill_attacker'
require_relative 'classes/kill_loss'
require_relative 'classes/kill'
require_relative 'classes/asset_container'
require_relative 'classes/asset'
require_relative 'classes/attribute_enhancer'
require_relative 'classes/certificate_tree'
require_relative 'classes/certificate_class'
require_relative 'classes/certificate_category'
require_relative 'classes/certificate'
require_relative 'classes/certificate_required_skill'
require_relative 'classes/certificate_required_certificate'
require_relative 'classes/character'
require_relative 'classes/character_sheet'
require_relative 'classes/corporation_member_security'
require_relative 'classes/corporation_member'
require_relative 'classes/corporation_sheet'
require_relative 'classes/conquerable_station'
require_relative 'classes/corporate_logo'
require_relative 'classes/corporate_role'
require_relative 'classes/corporate_title'
require_relative 'classes/corporate_division'
require_relative 'classes/corporate_medal'
require_relative 'classes/corporate_member_medal'
require_relative 'classes/character_info'
require_relative 'classes/character_medals'
require_relative 'classes/character_medal'
require_relative 'classes/wallet_division'
require_relative 'classes/map_jump'
require_relative 'classes/market_order'
require_relative 'classes/industry_job'
require_relative 'classes/map_kill'
require_relative 'classes/member_tracking'
require_relative 'classes/server_status'
require_relative 'classes/skill'
require_relative 'classes/skill_tree'
require_relative 'classes/skill_bonus'
require_relative 'classes/skill_in_tree'
require_relative 'classes/queued_skill'
require_relative 'classes/sovereignty'
require_relative 'classes/starbase'
require_relative 'classes/starbase_details'
require_relative 'classes/starbase_general_settings'
require_relative 'classes/starbase_combat_settings'
require_relative 'classes/starbase_fuel'
require_relative 'classes/wallet_balance'
require_relative 'classes/wallet_journal'
require_relative 'classes/corporate_wallet_transaction'
require_relative 'classes/personal_wallet_transaction'
require_relative 'classes/mailing_list'
require_relative 'classes/mail_message'
require_relative 'classes/notification'
require_relative 'classes/upcoming_calendar_events'
require_relative 'classes/account_status'

module Reve #:nodoc:
  module Classes #:nodoc:

    # This is just for getting the list and writing to test/xml/errors
    class APIError #:nodoc:
      attr_reader :code, :text
      def initialize(elem)
        @code = elem['errorCode'].to_i
        @text = elem['errorText']
      end
    end

    # Represents Reve::API#ref_types return. Used in WalletTransaction and WalletJournal, among others to qualify the "type" of the entry
    # Attributes
    # * id ( Fixnum ) - CCP's ID for the RefType
    # * name ( String ) - CCP's name for the RefType
    # See Also: Reve::API#ref_types, WalletJournal, WalletTransaction
    class RefType
      attr_reader :id, :name
      def initialize(elem) #:nodoc:
        @id   = elem['refTypeID'].to_i
        @name = elem['refTypeName']
      end
    end

  end
end
