require 'logix/version'
module Logix
  class Client

    attr_writer :user_agent

    # @return [String]
    def user_agent
      @user_agent ||= "Logix/#{Logix::VERSION}"
    end

  end
end
