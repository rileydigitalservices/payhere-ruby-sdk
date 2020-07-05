# Payhere API Ruby Gem

[![Gem Version](https://badge.fury.io/rb/payhere-sdk.svg)](https://badge.fury.io/rb/payhere-sdk)
[![Build Status](https://travis-ci.org/rileydigitalservices/payhere-sdk.svg?branch=master)](https://travis-ci.org/rileydigitalservices/payhere-sdk)
[![Coverage Status](https://coveralls.io/repos/github/rileydigitalservices/payhere-sdk/badge.svg?branch=master)](https://coveralls.io/github/rileydigitalservices/payhere-sdk?branch=master)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](code_of_conduct.md)
[![Join the community on Spectrum](https://withspectrum.github.io/badge/badge.svg)](https://spectrum.chat/payhere-api-sdk/)

## Usage

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'payhere-sdk'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install payhere-sdk

## Using credentials
Add the following configurations in an initializer file (for example, `config/initializers/payhere-sdk.rb` in a Rails app):

```
Payhere.configure do |config|
  config.version = 'Payhere API version you plan to use'
  config.envrionment = 'Specify if your testing the API or you are ready to do business'
  config.app_id = 'Payhere application id'
  config.username = 'Payhere username'
  config.password = 'Payhere password'
end
```

## Inpayments
Used to create an instance of inpayment


You can create an inpayment client with the following:

```ruby
require 'payhere-sdk'

inpayment = Payhere::Inpayments.new
```

### Methods
1. `request_to_pay`: This operation is used to request a payment from a Payer. The payer will be asked to authorize the payment. The transaction is executed once the payer has authorized the payment. The transaction will be in status PENDING until it is authorized or declined by the payer or it is timed out by the system. The status of the transaction can be validated by using `get_transaction_status`. 

2. `get_transaction_status`: Retrieve transaction information using the `transaction_reference` returned by `request_to_pay`. You can invoke it at intervals until the transaction fails or succeeds. If the transaction has failed, it will throw an appropriate error. 

## Outpayments
Used to create an instance of outpayment

You can create an outpayment client with the following:

```ruby
require 'payhere-sdk'

outpayment = Payhere::Outpayments.new
```

### Methods
1. `transfer`: Used to transfer an amount from the owner’s account to a payee account. The status of the transaction can be validated by using the `get_transaction_status` method.

2. `get_transaction_status`: Retrieve transaction information using the `transaction_reference` returned by `transfer`. You can invoke it at intervals until the transaction fails or succeeds. If the transaction has failed, it will throw an appropriate error. 

## Sample Code

```ruby
require 'payhere-sdk'

inpayment = Payhere::Inpayment.new 

transaction = inpayment.request_to_pay(
    phone_number="256772123456", amount=600, 
    procession_number="123456789", narration="dd")

transaction_ref = transaction[:transaction_reference]

inpayment.get_transaction_status(transaction_ref)

```

### Points to note:
All methods for Outpayments follow the same format as the examples shown above for Inpayments 

The 'transfer' method for Outpayemts follows the same format as 'request_to_pay' above.

## Additional documentation
For additional documentation, please refer to this link: https://apidocs.payhere.africa

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/rileydigitalservices/payhere-ruby-sdk. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Development

Install the gems using bundler

```bash
bundle install
```

Run the the unit tests:

```bash
rspec
```


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Payhere::Ruby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rileydigitalservices/payhere-ruby-sdk/blob/master/CODE_OF_CONDUCT.md).
