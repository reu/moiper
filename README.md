# Moiper

[Moip payment service](http://moip.com.br/) integration library.

## Installation

Add this line to your application's Gemfile:

    gem 'moiper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install moiper

## Usage

First, you need to set up your credentials:

```ruby
Moiper.configure do |config|
  config.token = "GJUXFM6H0CJX6WTELPH1QA9QG7JUFLTS"
  config.key = "EBBH4ARIGMEP9JWAKC0YJZMDHNLSPZAOTFES5DJK"
end
```

By default, you will make requests to the Moip's production API. You can enable the sandbox environment by setting the `sandbox` configuration:

```ruby
Moiper.configure do |config|
  config.sandbox = true
end
```

Then, you can request a new payment authorization:

```ruby
payment = Moiper::Payment.new(
  :description      => "A chair",
  :price            => 1.99,
  :id               => "some unique id",
  :return_url       => "http://example.org/thank_you",
  :notification_url => "http://example.org/moip/notification"
)

response = payment.checkout

if response.success?
  redirect_to response.checkout_url
else
  render :text => response.errors.to_sentence
end
```

You need to redirect your user to the url returned by `response.checkout_url`. After the user accepts or rejects your payment request, he will be redirected to the `return_url` you specified on the payment. In case of possible errors during the payment request phase, you can access then through the `response.errors` method.

### Notifications

Moip will notify your application about order updates through [NASP](http://labs.moip.com.br/referencia/nasp/). Moiper provides a Rails controller helper to you can easily intercept these notifications with the `moip_notification` method.

```ruby
class OrdersController < ApplicationController
  include Moiper::NotificationControllerHelper

  def confirm
    moip_notification do |notification|
      # Here you can update your database with updated information.
      # Ex:
      @order = Order.find_by_unique_identifier(notification.id)
      @order.update_attribute :status, notification.payment_status
      @order.save

      # Moip will recognize the request as successfully if the statuses
      # are 200, 201, 202, 203, 204, 205, 206 or 207.
      head 200
    end
  end
end
```

#### Payment Status

Following are the possible payment statuses returned by the `Moip::Notification#payment_status`.

* `authorized`
* `started`
* `payment_form_printed`
* `finished`
* `canceled`
* `under_analysis`
* `returned`
* `reimbursed`

#### Payment Methods

Following are the possible financial institutions returned by the `Moip::Notification#payment_method`.

* `payment_form`
* `credit_card`
* `debit`
* `debit_card`
* `financing`
* `moip_account`

#### Financial Institution

Following are the possible financial institutions returned by the `Moip::Notification#financial_institution`.

* MoIP
* Visa
* AmericanExpress
* Mastercard
* Diners
* BancoDoBrasil
* Bradesco
* Itau
* Hipercard
* Paggo
* Banrisul

## Disclaimer

This gem is being developed in a workshop-like manner, during the trainee training program at Tagview, so the students can understand concepts such as open source development, TDD, API integration and documentation.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
