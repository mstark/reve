# -*- coding: utf-8 -*-
require 'test_helper'

class TestReve < Test::Unit::TestCase

#This test verifies that we can connect to the CPP API Server.
#Dont care what data comes back, just as long as data comes back.
  def test_End_to_End_Connectivity_Test
    api = Reve::API.new
    errors = api.errors
    assert_not_nil(errors.inspect)
  end
end
