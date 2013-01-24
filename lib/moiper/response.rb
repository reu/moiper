module Moiper
  class Response
    # @param body [String] the response body from Moip
    def initialize(body)
      @body = body
    end

    # Detects if the response was successfully
    # @return [Boolean]
    def success?
      parsed_body.css("Status").text == "Sucesso"
    end

    # @return [String, nil] the URL which the user should be redirected
    #   to finish payment process or nil if the request was not successfully
    def checkout_url
      Moiper.api_entrypoint + "Instrucao.do?token=" + token if success?
    end

    # @return [String] the response token
    def token
      parsed_body.css("Token").text
    end

    # List the possible errors returned by Moip
    # @return [Array<String>]
    def errors
      parsed_body.css("Erro").map(&:text)
    end

    private

    def parsed_body
      @parsed_body ||= Nokogiri::XML(@body)
    end
  end
end
