# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Payhere::Inpayments do
  before(:all) do
    Payhere.configure do |config|
      config.base_url = 'http://sandbox.payhere.africa'
      config.username = 'sdk'
      config.password = 'sdk@2020'
      config.app_id = '11012'
    end
  end

  describe 'inpayments', vcr: { record: :new_episodes } do

    it 'gets transaction status' do
      ref = '1212881'
      expect { Payhere::Inpayments.new.get_transaction_status(ref) }
        .to raise_error(Payhere::Error)
    end

    it 'makes request to pay' do
      expect do
        Payhere::Inpayments.new.request_to_pay(
          '0775671360', 5.0, 
          '6353636', 'testing'
        )
      end .to raise_error(Payhere::Error)
    end
  end
end
