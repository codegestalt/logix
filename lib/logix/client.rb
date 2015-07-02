require 'logix/version'
module Logix
  class Client

    attr_accessor :password, :certificate, :private_key, :endpoint,
                  :soft_cert_authentication_endpoint

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
    #
    #
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

  end
end
