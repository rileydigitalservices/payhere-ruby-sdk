# frozen_string_literal: true

require 'payhere-sdk/config'
require 'payhere-sdk/version'
require 'payhere-sdk/inpayments'
require 'payhere-sdk/outpayments'

module Payhere
  class << self
    attr_accessor :config
  end

  def self.config
    @config ||= Config.new
  end

  def self.reset
    @config = Config.new
  end

  def self.configure
    yield(config)
  end
end
