module Moiper
  class Response
    def initialize(body)
      @body = body
    end

    def success?
      parsed_body.css("Status").text == "Sucesso"
    end

    def checkout_url
      Moiper.api_entrypoint + "Instrucao.do?token=" + token if success?
    end

    def token
      parsed_body.css("Token").text
    end

    def errors
      parsed_body.css("Erro").map(&:text)
    end

    private

    def parsed_body
      @parsed_body ||= Nokogiri::XML(@body)
    end
  end
end
