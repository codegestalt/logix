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

  describe '#inspect' do
    it "masks passwords on inspect" do
      client = Logix::Client.new(password: 'super secret')
      inspected = client.inspect
      refute_includes inspected, "super secret"
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

  describe '#login!' do
    # TODO: Provide test certificates
    subject {  Logix::Client.new(password: 'y0l0', certificate: "test/fixtures/certificate.crt.pem", private_key: "test/fixtures/private.key.pem", endpoint: "tb.raiffeisendirect.ch") }

    def setup
      stub_request(:post, 'https://tb.raiffeisendirect.ch/softCertLogin/offlinetool/?lang=en&password=y0l0').
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Length'=>'0', 'User-Agent'=>'Faraday v0.9.1'}).
        to_return( :status => 200,
                   :headers => {"set-cookie" => "RDI_SESS-S=AAABLtAPFyNkOTUwYTBkY2U2OWQ2MmM4ZmQ0YTJiNThlY2YxNGIyMgAATOU8_7f5FKQHmEfI0msWATyks8A=; path=/; secure; HttpOnly"},
                   :body => File.read('test/fixtures/login_success.xml'))
    end

    it 'sets the session_cookie attribute' do
      subject.login!
      assert_includes subject.session_cookie, "RDI_SESS-S="
    end

  end

end
