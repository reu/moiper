require "net/http"
require "net/https"

module Moiper
  class Request
    CA_FILE = File.expand_path(File.dirname(__FILE__)) + "/cacert.pem"

    attr_reader :response

    def process(payload)
      @response = post(payload)
      Response.new(@response.body)
    end

    def client
      @client ||= Net::HTTP.new(uri.host, uri.port).tap do |http|
        http.use_ssl = true
        http.ca_file = CA_FILE
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      end
    end

    def request
      @request ||= Net::HTTP::Post.new(uri.path).tap do |request|
        request.basic_auth Moiper.token, Moiper.key
        request.content_type = "text/xml"
        request["User-Agent"] = "Moiper/#{Moiper::VERSION}"
      end
    end

    private

    def post(payload)
      request.body = payload
      client.request(request)
    end

    def uri
      @uri ||= URI(Moiper.api_entrypoint + path)
    end

    def path
      "ws/alpha/EnviarInstrucao/Unica"
    end
  end
end
