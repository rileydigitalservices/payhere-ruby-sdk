# frozen_string_literal: true

# Validations for parameters passed into client methods

require 'payhere-sdk/errors'

module Payhere
  class Validate
    def validate(phone_number, amount)
      validate_string?(phone_number, 'Phone number')
      validate_numeric?(amount, 'Amount')
    end

    def validate_numeric?(num, field)
      return true if num.is_a? Numeric

      raise Payhere::ValidationError, "#{field} should be a number"
    end

    def validate_string?(str, field)
      return true if str.is_a? String

      raise Payhere::ValidationError, "#{field} should be a string"
    end
  end
end
