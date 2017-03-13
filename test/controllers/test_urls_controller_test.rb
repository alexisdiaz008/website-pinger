require 'test_helper'

class TestUrlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @test_url = test_urls(:one)
  end

  test "should get index" do
    get test_urls_url
    assert_response :success
  end

  test "should get new" do
    get new_test_url_url
    assert_response :success
  end

  test "should create test_url" do
    assert_difference('TestUrl.count') do
      post test_urls_url, params: { test_url: {  } }
    end

    assert_redirected_to test_url_url(TestUrl.last)
  end

  test "should show test_url" do
    get test_url_url(@test_url)
    assert_response :success
  end

  test "should get edit" do
    get edit_test_url_url(@test_url)
    assert_response :success
  end

  test "should update test_url" do
    patch test_url_url(@test_url), params: { test_url: {  } }
    assert_redirected_to test_url_url(@test_url)
  end

  test "should destroy test_url" do
    assert_difference('TestUrl.count', -1) do
      delete test_url_url(@test_url)
    end

    assert_redirected_to test_urls_url
  end
end
