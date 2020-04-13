# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Payhere::Outpayments do
  before(:all) do
    Payhere.configure do |config|
      config.base_url = 'http://sandbox.payhere.africa'
      config.username = 'sdk'
      config.password = 'sdk@2020'
      config.app_id = '11012'
    end
  end

  describe 'outpayments', vcr: { record: :new_episodes } do
    it 'gets transaction status' do
      ref = '88262655522'
      expect { Payhere::Outpayments.new.get_transaction_status(ref) }
        .to raise_error(Payhere::Error)
    end

    it 'makes transfer' do
      expect do
        Payhere::Outpayments.new.transfer(
          '0775671360', 5.0,
          '6353636', 'testing'
        )
      end .to raise_error(Payhere::Error)
    end
  end
end
