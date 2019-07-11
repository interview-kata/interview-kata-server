require 'test_helper'

class GithubControllerTest < ActionDispatch::IntegrationTest
  test "should get payload" do
    get github_payload_url
    assert_response :success
  end

end
