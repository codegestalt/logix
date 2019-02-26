require 'minitest_helper'

describe Logix do
  describe "VERSION" do
    it 'returns the correct current version' do
      assert_equal "0.0.4", Logix::VERSION
    end
  end
end
