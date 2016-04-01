require 'minitest_helper'

WebMock.allow_net_connect!

describe Logix::Client do

  def setup
    @client = Logix::Client.new(
      password: ENV['LOGIX_PASSWORD'],
      endpoint: ENV["LOGIX_FQDN"],
      certificate: File.read(File.expand_path(ENV["LOGIX_CERTIFICATE"])),
      private_key: File.read(File.expand_path(ENV["LOGIX_PRIVATE_KEY"])))
  end

  describe 'client' do
    it 'authenticates successfully' do
      assert @client.login!
    end
  end


end
