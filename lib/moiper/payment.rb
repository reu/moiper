require "nokogiri"

module Moiper
  class Payment
    # The unique ID you can set for this payment. This is usefull to keep
    # trak of which payment we will receive on the Moip's notification process.
    attr_accessor :id

    # The description of the purchase.
    attr_accessor :description

    # The amount to be billed from the user.
    attr_accessor :price

    # The URL where the user will be redirected after he finishes the
    # payment process.
    attr_accessor :return_url

    # The URL where Moip will send notifications about your purchase updates.
    attr_accessor :notification_url

    # Create a new Moip Payment request
    def initialize(options = {})
      raise ArgumentError if options[:description].nil? || options[:description].empty?
      raise ArgumentError if options[:price].nil? || options[:price].to_f <= 0

      options.each do |attribute, value|
        send "#{attribute}=", value
      end
    end

    # Create the payment XML representation
    def to_xml
      builder = Nokogiri::XML::Builder.new(:encoding => "UTF-8") do |xml|
        xml.EnviarInstrucao {
          xml.InstrucaoUnica {
            xml.Razao description
            xml.IdProprio id

            xml.Valores {
              xml.Valor price, :moeda => "BRL"
            }

            xml.URLNotificacao notification_url
            xml.URLRetorno return_url
          }
        }
      end

      builder.to_xml
    end
  end
end
