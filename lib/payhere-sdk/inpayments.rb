# frozen_string_literal: true

# Implementation of the Payhere API inpayments client

require 'securerandom'

require 'payhere-sdk/config'
require 'payhere-sdk/client'
require 'payhere-sdk/validate'

module Payhere
  class Inpayments < Client
    def get_transaction_status(transaction_id)
      path = "/inpayments/#{transaction_id}"
      super(path)
    end

    # This method is used to request a payment from a Payer
    # The payer will be asked to authorize the payment. The transaction will
    # be executed once the payer has authorized the payment.
    # The requesttopay will be in status PENDING until the transaction
    # is authorized or declined by the payer or it is timed out by the system.
    # The status of the transaction can be validated
    # by using `get_transation_status`
    def request_to_pay(phone_number, amount, processing_number = '', narration = '')
      Payhere::Validate.new.validate(phone_number, amount)
      processing_number = SecureRandom.uuid unless processing_number.blank?

      body = {
        "msisdn": phone_number,
        "narration": narration,
        "processingNumber": processing_number,
        "amount": amount.to_i
      }
      path = '/inpayments'
      send_request('post', path, body)
      { transaction_reference: uuid }
    end
    
  end
end
