require "moiper"

RSpec.configure do |config|
  config.before do
    Moiper.configure do |config|
      config.sandbox = true
      config.token = "01010101010101010101010101010101"
      config.key = "ABABABABABABABABABABABABABABABABABABABAB"
    end
  end
end
