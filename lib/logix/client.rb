require 'logix/version'
module Logix
  class Client

    # @return [String]
    def user_agent
      @user_agent ||= "Logix/#{Logix::VERSION}"
    end

  end
end
