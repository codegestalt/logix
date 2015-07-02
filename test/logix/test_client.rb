require 'minitest_helper'

class Logix::ClientTest < MiniTest::Test

  def test_get_user_agent_default
    client = Logix::Client.new 
    assert_equal "Logix/#{Logix::VERSION}", client.user_agent
  end

end
