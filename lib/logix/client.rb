require 'logix/version'
require 'faraday'
require 'crack'

module Logix
  class Client

    attr_accessor :password, :certificate, :private_key, :endpoint,
                  :soft_cert_authentication_endpoint, :soft_cert_activation_endpoint, :connection,
                  :session_cookie, :last_response

    attr_writer :user_agent

    # Public: Initialize new Client.
    # options - The Hash options used to refine the selection (default: {}):
    #           Required:
    #           :password  - Your initial password.
    #           :certificate  - String path to the certificate.crt.pem file.
    #           :private_key - String path to the key.crt.pem file.
    #           :endpoint - The FQDN of the banking API
    #           Optional:
    #           :soft_cert_authentication_endpoint - Default: '/softCertLogin'
    #           :soft_cert_activation_endpoint - Default: '/softCertActivation'
    #           :user_agent - Overwrite the default user agent
    #
    # Returns a Logix::Client object
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
    end

    # @return [String]
    def user_agent
      @user_agent ||= "Logix/#{Logix::VERSION}"
    end

    # @return [Boolean]
    def credentials?
      !!(password && certificate && private_key)
    end

    # @return [Boolean]
    def endpoint?
      !!(endpoint)
    end

    def soft_cert_authentication_endpoint
      @soft_cert_authentication_endpoint ||= '/softCertLogin'
    end

    def soft_cert_activation_endpoint
      @soft_cert_activation_endpoint ||= '/softCertActivation'
    end

    # Text representation of the client, masking passwords
    # @return [String]
    def inspect
      inspected = super
      # mask password
      inspected = inspected.gsub! @password, "*******" if @password
      inspected
    end

    # @returns true
    def login!
      @connection = setup_connection
      @connection.params = {'lang' => 'en', 'password' => @password}
      response = @connection.post("#{soft_cert_authentication_endpoint}/offlinetool/")
      @last_response = response
      body = Crack::XML.parse(response.body)
      @session_cookie = response.headers["set-cookie"]
      case
      when body["LOGIN_SOFT_CERT_RESPONSE"]["ErrorCode"].to_i == 0
        puts "Last Login: " + body["LOGIN_SOFT_CERT_RESPONSE"]["LastLogin"]
        true
      else
        false
      end
    end

    private

    def setup_connection
      Faraday::Connection.new "https://#{@endpoint}",
        :ssl => {
        :client_cert  => OpenSSL::X509::Certificate.new(File.read(@certificate)),
        :client_key   => OpenSSL::PKey::RSA.new(File.read(@private_key))
        }
    end
  end
end
