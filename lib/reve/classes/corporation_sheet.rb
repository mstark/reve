module Reve #:nodoc
  module Classes #:nodoc

    # Describes a Corporation. The public listing when a Corporation is in an Alliance is limited. When the requestor is in the Corporation for which the CorporationSheet is for then the details are full.
    # Attributes
    # * id ( Fixnum ) - ID of the Corporation
    # * name ( String ) - Name of the Corporation
    # * ticker ( String ) - Ticker (short name) of the Corporation
    # * ceo_id ( Fixnum ) - The ID of the Character who is the CEO of the Corporation
    # * ceo_name ( String ) - The name of the Character whois he CEO of the Corporation
    # * station_id ( Fixnum ) - The ID of the Corporation's home Station
    # * station_name ( Station ) - The name of the Corporation's home Station
    # * description ( String ) - Corporation's description
    # * url ( String ) - URL of the Corporation's website. If none is set the value is an empty String
    # * alliance_id ( Fixnum | NilClass ) - ID of the Alliance that this Corporation belongs to; nil if no membership
    # * alliance_name ( String | NilClass ) - Name of the Alliance that this Corporation belongs to; nil if no membership
    # * tax_rate ( Float ) - Tax rate for the Corporation
    # * member_count ( Fixnum ) - How many Characters are in the Corporation
    # * member_limit ( Fixnum ) - Member limit (Max number of Characters allowed in?)
    # * shares ( Fixnum ) - Number of shares available for the Corporation
    # * divisions ( [CorporateDivision] ) - Array of CorporateDivision objects representing the differet divisions in the Corporation
    # * wallet_divisions ( [WalletDivision] ) - Array of WalletDivision objects representing the different divisions in the wallet for the Corporation
    # * logo ( CorporateLogo ) - An object to represent the Corporation's logo.
    # See Also: CorporateLogo, WalletDivision, CorporateDivision, Corporation, Reve::API#corporation_sheet
    class CorporationSheet
      attr_reader   :id, :name, :ticker, :ceo_id, :ceo_name, :station_id, :station_name, :description, :url,
                    :alliance_id, :alliance_name, :tax_rate, :member_count, :member_limit, :shares
      attr_accessor :divisions, :wallet_divisions, :logo

      # Call it +h+ here cos it's a Hash and not any Hpricot object like in other constructors
      def initialize(h, divisions = [],wallet_divisions = [], logo =Reve::Classes::CorporateLogo.new(Hash.new(0)) ) #:nodoc:
        @divisions = divisions
        @wallet_divisions = wallet_divisions
        @logo = logo
        @id = h[:id].to_i
        @name = h[:name]
        @ticker = h[:ticker]
        @ceo_id = h[:ceo_id].to_i
        @ceo_name = h[:ceo_name]
        @station_id = h[:station_id].to_i
        @station_name = h[:station_name]
        @description = h[:description].split(/\n/).collect { |s| s.strip }.join(' ') # newlines to spaces
        @url = h[:url] || ""
        @alliance_id = h[:alliance_id].to_i rescue nil
        @alliance_name = h[:alliance_name] rescue nil
        @tax_rate = h[:tax_rate].to_f
        @member_count = h[:member_count].to_i
        @member_limit = h[:member_limit].to_i
        @shares = h[:shares].to_i
      end
    end

  end
end
