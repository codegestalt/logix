require 'minitest_helper'

class Logix::VersionTest < MiniTest::Test

  def test_version
    assert_equal "0.0.1", Logix::VERSION
  end

end
