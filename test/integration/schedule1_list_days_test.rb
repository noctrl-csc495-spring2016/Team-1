require 'test_helper'

class Schedule1ListDaysTest < ActionDispatch::IntegrationTest
  def setup
    @day = users(:michael)
  end

  #need to add tests for content and for link
  test "list including pagination" do
    log_in_as(@day)
    get users_path
    assert_template 'pages/schedule/schedule1'
    assert_select 'div.pagination'
    #need to implement this test!!!@$@$@$
    # day.paginate(page: 1).each do |day|
    #   assert_select 'a[href=?]', user_path(user), text: user.name
    #end
  end
end
