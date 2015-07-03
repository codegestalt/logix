require 'minitest_helper'

describe "External request" do

  def setup
    stub_request(:get, /tb.raiffeisendirect.ch/).
      with(headers: {'Accept' => '*/*', 'User-Agent' => 'Ruby'}).
      to_return(status: 200, body: "stubbed response", headers: {})
  end

  it 'queries the login path' do
    uri = URI('https://tb.raiffeisendirect.ch/')
    response = Net::HTTP.get(uri)

    assert_instance_of String, response
  end

end
