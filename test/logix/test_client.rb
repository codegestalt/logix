require 'minitest_helper'

describe Logix::Client do

  subject { Logix::Client.new }

  describe "#user_agent" do
    it 'defaults LogixRubyGem/version' do
      assert_equal "Logix/#{Logix::VERSION}", subject.user_agent
    end
  end

  describe "#user_agent=" do
    it 'overwrites the User-Agent string' do
      subject.user_agent = "CustomLogixClient/0.0.1"
      assert_equal "CustomLogixClient/0.0.1", subject.user_agent
    end
  end

end
