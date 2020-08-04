require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Atode"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title","#{@base_title}"
  end

  test "shold get about" do
    get about_path
    assert_response :success
    assert_select "title","About | #{@base_title}"
  end

end
