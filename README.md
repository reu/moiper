# Moiper

Moip payment service integration library.

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

To make a payment request:

```ruby
payment = Moiper::Payment.new(
  :description      => "A chair",
  :price            => 1.99,
  :id               => "some unique id",
  :return_url       => "http://example.org/thank_you",
  :notification_url => "http://example.org/moip/notification"
)

response = payment.checkout

redirect_to response.checkout_url if payment.success?
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
