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

  describe "#credentials?" do
    it 'returns true if all credentials are present' do
      client = Logix::Client.new(password: 'y0l0', certificate: "./path/to/certificate.crt.pem", private_key: "./path/to/private.key.pem")
      assert_equal true, client.credentials?
    end
    it 'returns false if any credentials are missing' do
      client = Logix::Client.new(password: 'y0l0', certificate: "./path/to/certificate.crt.pem")
      assert_equal false, client.credentials?
    end
  end

end
