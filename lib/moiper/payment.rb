require "nokogiri"

module Moiper
  class Payment
    # @return [String] the unique ID you can set for this payment. This is usefull to keep
    #   track of which payment we will receive on the Moip's notification process
    attr_accessor :id

    # @return [String] the description of the purchase
    attr_accessor :description

    # @return [Float] the amount to be billed from the user
    attr_accessor :price

    # @return [Float] the amount to be increased from the final price
    attr_accessor :accretion

    # @return [Float] the amount to be deducted from the final price
    attr_accessor :deduction

    # @return [String] the URL where the user will be redirected after he finishes the
    #   payment process.
    attr_accessor :return_url

    # @return [String] the URL where Moip will send notifications about your purchase updates
    attr_accessor :notification_url

    # Create a new Moip Payment request
    #
    # @param [Hash] options the options to create the payment with
    # @option options [String] :description {#description}
    # @option options [String, #to_s] :id {#id}
    # @option options [#to_f] :price {#price}
    # @option options [#to_f] :accretion {#accretion}
    # @option options [#to_f] :deduction {#deduction}
    # @option options [String, #to_s] :return_url {#return_url}
    # @option options [String, #to_s] :notification_url {#notification_url}
    #
    # @raise [ArgumentError] if description or price options are blank
    def initialize(options = {})
      raise ArgumentError, "You must inform a description" if options[:description].nil? || options[:description].empty?
      raise ArgumentError, "You must inform a price" if options[:price].nil? || options[:price].to_f <= 0

      options.each do |attribute, value|
        send "#{attribute}=", value
      end
    end

    # Create the payment XML representation
    # @return [String] Moip's formatted XML
    def to_xml
      builder = Nokogiri::XML::Builder.new(:encoding => "UTF-8") do |xml|
        xml.EnviarInstrucao {
          xml.InstrucaoUnica {
            xml.Razao description
            xml.IdProprio id if id

            xml.Valores {
              xml.Valor price, :moeda => "BRL"
              xml.Acrescimo accretion, :moeda => "BRL" if accretion
              xml.Deducao deduction, :moeda => "BRL" if deduction
            }

            xml.URLNotificacao notification_url if notification_url
            xml.URLRetorno return_url if return_url
          }
        }
      end

      builder.to_xml
    end

    # Send a new payment request to Moip
    # @return [Response] the Moip response
    def checkout
      request = Request.new
      request.process(to_xml)
    end
  end
end
