require 'test_helper'

class CertificateTreeTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_certificate_sheet
    Reve::API.certificate_tree_url = XML_BASE + 'certificate_tree.xml'
    tree = nil

    assert_nothing_raised do
      tree = @api.certificate_tree
    end
    # going to hell
    assert_kind_of(Reve::Classes::CertificateTree, tree)
    assert_equal(1, tree.categories.size)
    assert tree.categories.all? { |cat| cat.kind_of?(Reve::Classes::CertificateCategory) }
    assert tree.categories.all? { |cat| cat.id.kind_of?(Numeric) && cat.name.kind_of?(String) }
    assert_equal(6, tree.categories.first.classes.size) # just 1 category
    assert tree.categories.first.classes.all? { |klass| klass.kind_of?(Reve::Classes::CertificateClass) }
    assert tree.categories.first.classes.all? { |klass| klass.id.kind_of?(Numeric) && klass.name.kind_of?(String) }
    assert tree.categories.first.classes.collect { |klass| klass.certificates }.flatten.all? { |cert| cert.id.kind_of?(Numeric) && cert.grade.kind_of?(Numeric) && cert.corporation_id.kind_of?(Numeric) && cert.description.kind_of?(String) }
    assert_equal(20, tree.categories.first.classes.collect { |klass| klass.certificates }.flatten.size)
    assert_equal(54, tree.categories.first.classes.collect { |klass| klass.certificates }.flatten.collect { |cert| cert.required_skills }.flatten.size)
    assert tree.categories.first.classes.collect { |klass| klass.certificates }.flatten.collect { |cert| cert.required_skills }.flatten.all? { |req| req.id.kind_of?(Numeric) && req.level.kind_of?(Numeric) }
    assert_equal(29, tree.categories.first.classes.collect { |klass| klass.certificates }.flatten.collect { |cert| cert.required_certificates }.flatten.size)
    assert tree.categories.first.classes.collect { |klass| klass.certificates }.flatten.collect { |cert| cert.required_certificates }.flatten.all? { |req| req.id.kind_of?(Numeric) && req.grade.kind_of?(Numeric) }
  end


end
