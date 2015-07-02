$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'logix'

require 'minitest/autorun'
require 'webmock/minitest'

WebMock.disable_net_connect!(allow_localhost: true)


def test_fqdn
  ENV.fetch 'LOGIX_FQDN', 'td.mybank.com'
end

def test_password
  ENV.fetch 'LOGIX_PASSWORD', 'supersecret'
end

def test_certificate
  ENV.fetch 'LOGIX_CERTIFICATE', '/tmp/fake_certificate_path.crt.pem'
end

def test_certificate
  ENV.fetch 'LOGIX_PRIVATE_KEY', '/tmp/fake_certificate_path.key.pem'
end
