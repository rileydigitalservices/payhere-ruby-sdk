# frozen_string_literal: true

# Configurations are set up in this file
# for a user's Payhere API user credentials

module Payhere
  class Config
    attr_writer   :base_url
    attr_accessor :environment, :version, :app_id, 
                  :username, :password

    def initialize
      @environment = nil
      @version = nil
      @base_url = nil
      @app_id = nil
      @username = nil
      @password = nil
    end

    def base_url
      @base_url || 'http://api.payhere.africa'
    end
  end
end
