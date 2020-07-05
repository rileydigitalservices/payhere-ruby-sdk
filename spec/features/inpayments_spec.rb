# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Payhere::Inpayments do
  before(:all) do
    Payhere.configure do |config|
      config.username = '20000'
      config.environment = 'sandbox'
      config.version = 'v1'
      config.password = 'sdk@2020'
      config.app_id = '10000100'
    end
  end

  describe 'inpayments', vcr: { record: :new_episodes } do
    context "when user is logged in" do
      it 'makes request to pay' do
        request_to_pay = Payhere::Inpayments.new.request_to_pay('0775671360',5.0,'6353636', 'testing')
        expect(request_to_pay.status).to eq(:created)
      end
      it 'gets transaction status' do
        ref = '1-payhere-airtel-111111'
        expect { Payhere::Inpayments.new.get_transaction_status(ref) }
            .to raise_error(Payhere::Error)
        end
      end
    end
    
    context "when user is not logged in" do
      it 'fail to get financial status' do
        ref = '1212881'
        expect { Payhere::Inpayments.new.get_transaction_status(ref) }
            .to raise_error(Payhere::Error)
      end
    end
end
