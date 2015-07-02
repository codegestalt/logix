require 'minitest_helper'

describe Logix::Client do

  subject { Logix::Client.new }

  describe '#user_agent' do
    it 'defaults LogixRubyGem/version' do
      assert_equal "Logix/#{Logix::VERSION}", subject.user_agent
    end

    it 'overwrites the User-Agent string' do
      subject.user_agent = "CustomLogixClient/0.0.1"
      assert_equal "CustomLogixClient/0.0.1", subject.user_agent
    end
  end

  describe '#endpoint?' do
    it 'returns true if the endpoint is present' do
      client = Logix::Client.new(endpoint: "tb.raiffeisendirect.ch")
      assert_equal true, client.endpoint?
    end

    it 'returns false if the endpoint is missing' do
      client = Logix::Client.new()
      assert_equal false, client.endpoint?
    end
  end

  describe '#credentials?' do
    it 'returns true if all credentials are present' do
      client = Logix::Client.new(password: 'y0l0', certificate: "./path/to/certificate.crt.pem", private_key: "./path/to/private.key.pem")
      assert_equal true, client.credentials?
    end

    it 'returns false if any credentials are missing' do
      client = Logix::Client.new(password: 'y0l0', certificate: "./path/to/certificate.crt.pem")
      assert_equal false, client.credentials?
    end
  end

  describe '#soft_cert_authentication_endpoint' do
    it 'defaults the :soft_cert_authentication_endpoint' do
      assert_equal '/softCertLogin', subject.soft_cert_authentication_endpoint
    end

    it 'overwrites the :soft_cert_authentication_endpoint' do
      subject.soft_cert_authentication_endpoint = '/differentCertLogin'
      assert_equal '/differentCertLogin', subject.soft_cert_authentication_endpoint
    end
  end

  describe '#soft_cert_activation_endpoint' do
    it 'defaults the :soft_cert_activation_endpoint' do
      assert_equal '/softCertActivation', subject.soft_cert_activation_endpoint
    end

    it 'overwrites the :soft_cert_activation_endpoint' do
      subject.soft_cert_activation_endpoint = '/differentCertActivation'
      assert_equal '/differentCertActivation', subject.soft_cert_activation_endpoint
    end
  end

end
