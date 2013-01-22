require "moiper/version"
require "moiper/payment"
require "moiper/request"
require "moiper/response"

module Moiper
  API_ENTRYPOINTS = {
    :sandbox    => "https://desenvolvedor.moip.com.br/sandbox/",
    :production => "https://www.moip.com.br/"
  }

  class << self
    # Set Moip's API token
    attr_accessor :token

    # Set Moip's API key
    attr_accessor :key

    # Define if requests should be made against Moip's sandbox
    # environment. This is specially usefull when running
    # on development or test mode. Default is false.
    #
    #  Moiper.sandbox = true
    #
    attr_accessor :sandbox

    # Configure Moiper options.
    #
    #  Moiper.configure do |config|
    #    config.sandbox = true
    #  end
    #
    def configure(&block)
      yield self
    end

    # Inform if in sandbox mode
    def sandbox?
      sandbox == true
    end

    # Returns the Moip API entrypoint based on the current environment
    def api_entrypoint
      sandbox? ? API_ENTRYPOINTS[:sandbox] : API_ENTRYPOINTS[:production]
    end
  end
end
