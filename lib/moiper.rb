require "moiper/version"
require "moiper/payment"
require "moiper/request"
require "moiper/response"
require "moiper/notification"
require "moiper/railtie" if defined? Rails

module Moiper
  # The available Moip entrypoints
  # @see http://labs.moip.com.br/referencia/autenticacao_api/#ambientes
  #   The Moip's official documentation regarding its entrypoints
  API_ENTRYPOINTS = {
    :sandbox    => "https://desenvolvedor.moip.com.br/sandbox/",
    :production => "https://www.moip.com.br/"
  }

  class << self
    # @!group Configurable options

    # @return [String] Moip's API token
    attr_accessor :token

    # @return [String] Moip's API key
    attr_accessor :key

    # Define if requests should be made against Moip's sandbox
    # environment. This is specially usefull when running
    # on development or test mode. Default is false
    #
    # @see http://labs.moip.com.br/referencia/autenticacao_api/#sandbox
    #   Moip's official documentation regarding sandbox activation
    #
    # @example
    #   Moiper.sandbox = true
    #
    # @return [Boolean] current sandbox state
    attr_accessor :sandbox

    # @!endgroup

    # Configure Moiper's options
    #
    # @yieldparam config [Moiper]
    # @return [void]
    #
    # @example
    #   Moiper.configure do |config|
    #     config.sandbox = true
    #   end
    #
    def configure(&block)
      yield self
    end

    # Inform if in sandbox mode
    def sandbox?
      sandbox == true
    end

    # @return [String] the Moip API entrypoint based on the current environment
    def api_entrypoint
      sandbox? ? API_ENTRYPOINTS[:sandbox] : API_ENTRYPOINTS[:production]
    end
  end
end
