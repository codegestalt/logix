require 'logix/version'
require 'logix/raiffeisen_field_parser'
require 'faraday'
require 'faraday-cookie_jar'
require 'crack'

module Logix
  class Client

    attr_accessor :password, :certificate, :private_key, :endpoint,
                  :soft_cert_authentication_endpoint, :soft_cert_activation_endpoint, :connection,
                  :last_response

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

    # TODO: Implement
    def sys_info
    end

    # TODO: Implement
    def authenticate!
    end

    # @returns true
    def login!
      @connection = setup_connection
      @connection.params = {'lang' => 'en', 'password' => @password}
      response = @connection.post("#{soft_cert_authentication_endpoint}/offlinetool/")
      @last_response = response
      body = Crack::XML.parse(response.body)
      case
      when body["LOGIN_SOFT_CERT_RESPONSE"]["ErrorCode"].to_i == 0
        true
      else
        false
      end
    end

    # Public: Downloads MT940 Files
    # options - The Hash options used to refine the selection (default: {}):
    #           Required:
    #           :account_number  - value: All
    #           :data_type  - values:
    #             allMT940: (default)
    #             newMT940: (only not yet downloaded data)
    #             oldMT940: (only already downloaded data)
    #           Optional:
    #           :start_date - Booking date range (mandatory if data_type = allMT940)
    #           :end_date - Booking date range (mandatory if data_type = allMT940)
    #
    # Returns a cmxl MT940 Data file
    def mt940_download(options = {})
      account_number = options[:account_number] || 'All'
      data_type = options[:data_type] || 'allMT940'
      download = "Download"
      output = "Xml"
      @connection.params = {'lang' => 'en',
                            'MT940AccountNumber' => account_number,
                            'MT940DataType' => data_type,
                            'Download' => download,
                            'output' => output}
      if options[:start_date] && options[:end_date]
        @connection.params = @connection.params.merge({'StartDate' => options[:start_date],
                                                       'EndDate' => options[:end_date]})
      end

      response = @connection.get("/root/datatransfer/mt940download")
      @last_response = response
      raw_mt940 = Crack::XML.parse(response.body)["MT940_RESPONSE"]["EXPORT_DATA"]
      Cmxl.parse(raw_mt940, encoding: 'UTF-8')
    end

    # TODO: Implement
    def logout
      puts 'not yet implemented!'
    end

    # TODO: Implement
    def session_status
      puts 'not yet implemented!'
    end

    # TODO: Implement
    def login_time
      puts 'not yet implemented!'
    end

    # TODO: Implement
    def esr_download
      puts 'not yet implemented!'
    end

    # TODO: Implement
    def ipi_download
      puts 'not yet implemented!'
    end

    # TODO: Implement
    def lsv_download
      puts 'not yet implemented!'
    end

    # TODO: Implement
    def mt471_download
      puts 'not yet implemented!'
    end

    # TODO: Implement
    def mt536_download
      puts 'not yet implemented!'
    end

    # TODO: Implement
    def mt5xx_download
      puts 'not yet implemented!'
    end

    # TODO: Implement
    def dta_upload
      puts 'not yet implemented!'
    end

    # TODO: Implement
    def dta_status_request
      puts 'not yet implemented!'
    end

    # TODO: Implement
    def download_bank_document_categories
      puts 'not yet implemented!'
    end

    # TODO: Implement
    def download_bank_documents
      puts 'not yet implemented!'
    end

    private

    def setup_connection
      connection = Faraday::Connection.new("https://#{@endpoint}",
          :ssl => {:client_cert  => OpenSSL::X509::Certificate.new(File.read(@certificate)), :client_key   => OpenSSL::PKey::RSA.new(File.read(@private_key))
        }) do |builder|
          builder.use :cookie_jar
          builder.adapter Faraday.default_adapter
        end
      connection
    end

  end
end
