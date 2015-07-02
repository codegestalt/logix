require 'logix/version'
module Logix
  class Client

    attr_accessor :password, :certificate, :private_key
    attr_writer :user_agent

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

  end
end
