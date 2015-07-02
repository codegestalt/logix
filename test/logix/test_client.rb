require 'minitest_helper'

class Logix::ClientTest < MiniTest::Test

  def setup
    @client = Logix::Client.new
  end

  def test_get_user_agent_default
    assert_equal "Logix/#{Logix::VERSION}", @client.user_agent
  end

  def test_overwrite_user_agent
    @client.user_agent = "CustomLogixClient/0.0.1"
    assert_equal "CustomLogixClient/0.0.1", @client.user_agent
  end

end
