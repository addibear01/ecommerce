# frozen_string_literal: true

require 'test_helper'

class TeddyTypesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get teddy_types_index_url
    assert_response :success
  end

  test 'should get show' do
    get teddy_types_show_url
    assert_response :success
  end
end
