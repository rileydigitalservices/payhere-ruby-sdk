# frozen_string_literal: true

# Implementation of Payhere API outpayments client

require 'payhere-sdk/config'
require 'payhere-sdk/client'

module Payhere
  class Outpayments < Client
    def get_transaction_status(transaction_id)
      path = "/outpayments/#{transaction_id}"
      super(path)
    end

    # The transfer operation is used to transfer an amount from the payer's
    # account to a payee account.
    # The status of the transaction can be validated
    # by using `get_transation_status`
    def transfer(phone_number, amount, processing_number = '', narration = '')
      Payhere::Validate.new.validate(phone_number, amount)
      processing_number = SecureRandom.uuid unless processing_number.blank?

      body = {
        "msisdn": phone_number,
        "narration": narration,
        "processingNumber": processing_number,
        "amount": amount.to_i
      }
      path = '/outpayments'

      send_request('post', path, body)
      { processing_number: processing_number }
    end
 
  end
end
