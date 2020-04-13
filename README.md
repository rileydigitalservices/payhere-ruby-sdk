# Riley Digital Services Payhere API Ruby Gem

[![Gem Version](https://badge.fury.io/rb/payhere-sdk-sdk.svg)](https://badge.fury.io/rb/payhere-sdk-sdk)
[![Build Status](https://travis-ci.com/rileydigitalservices/payhere-sdk-sdk.svg?branch=master)](https://travis-ci.com/rileydigitalservices/payhere-sdk-sdk)
[![Coverage Status](https://coveralls.io/repos/github/rileydigitalservices/payhere-sdk-sdk/badge.svg?branch=master)](https://coveralls.io/github/rileydigitalservices/payhere-sdk-sdk?branch=master)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](code_of_conduct.md)
[![Join the community on Spectrum](https://withspectrum.github.io/badge/badge.svg)](https://spectrum.chat/payhere-api-sdk/)

## Usage

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'payhere-sdk-sdk'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install payhere-sdk-sdk

## Using credentials
Add the following configurations in an initializer file (for example, `config/initializers/payhere-sdk-sdk.rb` in a Rails app):

```
Payhere.configure do |config|
  config.base_url = 'Payhere account base URL'
end
```

## Inpayments
The collections client can be created with the following paramaters. Note that the `COLLECTION_USER_ID` and `COLLECTION_API_SECRET` for production are provided on the MTN OVA dashboard.

Add the following to your configuration block:
```
  config.collection_primary_key = 'Your Collection Subscription Key'
  config.collection_user_id = 'Your Collection User ID'
  config.collection_api_secret = 'Your Collection API Key'
```

* `collection_primary_key`: Primary Key for the `Collection` product on the developer portal.
* `collection_user_id`: For sandbox, use the one generated with the `payhere-sdk-sdk` command.
* `collection_api_secret`: For sandbox, use the one generated with the `payhere-sdk-sdk` command.

You can create a collection client with the following:

```ruby
require 'payhere-sdk-sdk'

collection = Payhere::Collection.new
```

### Methods
1. `request_to_pay`: This operation is used to request a payment from a consumer (Payer). The payer will be asked to authorize the payment. The transaction is executed once the payer has authorized the payment. The transaction will be in status PENDING until it is authorized or declined by the payer or it is timed out by the system. The status of the transaction can be validated by using `get_transaction_status`. 

2. `get_transaction_status`: Retrieve transaction information using the `transaction_reference` returned by `request_to_pay`. You can invoke it at intervals until the transaction fails or succeeds. If the transaction has failed, it will throw an appropriate error. 

3. `get_balance`: Get the balance of the account.


## Disbursements
The disbursements client can be created with the following paramaters. The `DISBURSEMENT_USER_ID` and `DISBURSEMENT_API_SECRET` for production are provided on the MTN OVA dashboard.

Add the following to your configuration block:
```
  config.disbursement_primary_key = 'Your Disbursement Subscription Key'
  config.disbursement_user_id = 'Your Disbursement User ID'
  config.disbursement_api_secret = 'Your Disbursement API Key'
```

* `disbursement_primary_key`: Primary Key for the `Disbursement` product on the developer portal.
* `disbursement_user_id`: For sandbox, use the one generated with the `payhere-sdk-sdk` command.
* `disbursement_api_secret`: For sandbox, use the one generated with the `payhere-sdk-sdk` command.

You can create a disbursement client with the following:

```ruby
require 'payhere-sdk-sdk'

disbursement = Payhere::Disbursement.new
```

### Methods
1. `transfer`: Used to transfer an amount from the owner’s account to a payee account. The status of the transaction can be validated by using the `get_transaction_status` method.

2. `get_transaction_status`: Retrieve transaction information using the `transaction_reference` returned by `transfer`. You can invoke it at intervals until the transaction fails or succeeds. If the transaction has failed, it will throw an appropriate error. 

3. `get_balance`: Get the balance of the account.


## Remittances
The remittances client can be created with the following paramaters. The `REMITTANCES_USER_ID` and `REMITTANCES_API_SECRET` for production are provided on the MTN OVA dashboard.

Add the following to your configuration block:
```
  config.remittance_primary_key = 'Your Remittance Subscription Key'
  config.remittance_user_id = 'Your Remittance User ID'
  config.remittance_api_secret = 'Your Remittance API Key'
```

* `remittance_primary_key`: Primary Key for the `Remittance` product on the developer portal.
* `remittance_user_id`: For sandbox, use the one generated with the `payhere-sdk-sdk` command.
* `remittance_api_secret`: For sandbox, use the one generated with the `payhere-sdk-sdk` command.

You can create a remittance client with the following:

```ruby
require 'payhere-sdk-sdk'

remittance = Payhere::Remittance.new
```

### Methods
1. `transfer`: Used to transfer an amount from the owner’s account to a payee account. The status of the transaction can be validated by using the `get_transaction_status` method. 

2. `get_transaction_status`: Retrieve transaction information using the `transaction_reference` returned by `transfer`. You can invoke it at intervals until the transaction fails or succeeds. If the transaction has failed, it will throw an appropriate error. 

3. `get_balance`: Get the balance of the account.


## Sample Code

```ruby
require 'payhere-sdk-sdk'

collection = Payhere::Collection.new 

collection.is_user_active('256772123456')

collection.get_balance

transaction = collection.request_to_pay(
    phone_number="256772123456", amount=600, external_id="123456789", payee_note="dd", payer_message="dd", currency="EUR")

transaction_ref = transaction[:transaction_reference]

collection.get_transaction_status(transaction_ref)

```

### Points to note:
All methods for Disbursements and Remittances follow the same format as the examples shown above for Collections 

The 'transfer' method for Disbursements and Remittances follows the same format as 'request_to_pay' above.

An extra argument, `callback_url`, can be passed to the 'request_to_pay' and 'transfer' methods, denoting the URL to the server where the callback should be sent.

## Additional documentation
For additional documentation, please refer to this link: https://www.rubydoc.info/gems/payhere-sdk-sdk/1.0.0

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rileydigitalservices/payhere-sdk-sdk. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Payhere::Ruby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rileydigitalservices/payhere-sdk-sdk/blob/master/CODE_OF_CONDUCT.md).
