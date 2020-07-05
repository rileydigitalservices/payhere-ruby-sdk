# frozen_string_literal: true

# Configurations are set up in this file
# for a user's Payhere API user credentials

module Payhere
  class Config
    attr_accessor :environment, :version, :app_id, 
                  :username, :password, :version

    def initialize
      @environment = nil
      @version = nil
      @app_id = nil
      @username = nil
      @password = nil
    end

  end
end
