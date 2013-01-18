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

```ruby
Moiper.configure do |config|
  config.token = "GJUXFM6H0CJX6WTELPH1QA9QG7JUFLTS"
  config.key = "EBBH4ARIGMEP9JWAKC0YJZMDHNLSPZAOTFES5DJK"
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
