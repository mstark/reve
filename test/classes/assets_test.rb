require 'test_helper'

class AssetsTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_assets
    Reve::API.personal_assets_url = XML_BASE + 'assets.xml'
    assets = nil
    assert_nothing_raised do
      assets = @api.personal_assets_list
    end
    assert_equal 19, assets.size # 18 single and 1 container
    contained_assets = assets.select { |ass| ass.instance_of? Reve::Classes::AssetContainer}

    assert_equal(1, contained_assets.size) # We have a container it happens to have 1 asset in it
    contained_assets.each do |asset|
      assert_instance_of(Reve::Classes::AssetContainer, asset)
      assert_not_nil(asset.item_id)
      assert_not_nil(asset.location_id)
      assert_not_nil(asset.type_id)
      assert_not_nil(asset.quantity)
      assert_not_nil(asset.flag)
      assert_not_nil(asset.singleton)
    end
    assets.select { |ass| ass.instance_of? Reve::Classes::Asset}.each do |asset|
      assert_instance_of(Reve::Classes::Asset, asset)
      assert_not_nil(asset.item_id)
      assert_not_nil(asset.location_id)
      assert_not_nil(asset.type_id)
      assert_not_nil(asset.quantity)
      assert_not_nil(asset.flag)
      assert_not_nil(asset.singleton)
    end
  end

  def test_corporate_assets_list_clean
    assets = nil
    assert_nothing_raised do
      assets = @api.corporate_assets_list(:url => File.join(XML_BASE,'corporate_assets_list.xml'))
    end
    assert_equal 2, assets.size
    assert assets[0].kind_of?(Reve::Classes::Asset)
    assert assets[1].kind_of?(Reve::Classes::AssetContainer)
  end

  def test_corporate_assets_list_nesting_clean
    assets = nil
    assert_nothing_raised do
      assets = @api.corporate_assets_list :url => File.join(XML_BASE,'corporate_assets_list_nesting.xml')
    end

    assert_equal 3, assets.size
    assert assets[0].kind_of?(Reve::Classes::Asset)
    assert assets[1].kind_of?(Reve::Classes::AssetContainer)
    assert assets[2].kind_of?(Reve::Classes::Asset)

    first_container = assets[1]
    assert_equal 2, first_container.type_id
    assert_equal 2, first_container.assets.size

    second_container = first_container.assets[0]
    assert_equal 3, second_container.type_id
    assert_equal 1, second_container.assets.size
    assert second_container.assets[0].kind_of?(Reve::Classes::Asset)

    nested_item = second_container.assets[0]
    assert_equal 640, nested_item.type_id
  end

end
