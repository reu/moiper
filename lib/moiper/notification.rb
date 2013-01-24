module Moiper
  class Notification
    # @see http://labs.moip.com.br/parametro/statuspagamento/
    #   The list of payment status on the Moip's official documentation
    PAYMENT_STATUSES = {
      1 => :authorized,
      2 => :started,
      3 => :payment_form_printed,
      4 => :finished,
      5 => :canceled,
      6 => :under_analysis,
      7 => :returned,
      9 => :reimbursed
    }

    # @see http://labs.moip.com.br/parametro/instituicaopagamento/
    #   The list of financial institutions on the Moip's official documentation
    FINANCIAL_INSTITUTIONS = {
      1 => "MoIP",
      3 => "Visa",
      7 => "AmericanExpress",
      5 => "Mastercard",
      6 => "Diners",
      8 => "BancoDoBrasil",
      22 => "Bradesco",
      13 => "Itau",
      75 => "Hipercard",
      76 => "Paggo",
      88 => "Banrisul"
    }

    # @see http://labs.moip.com.br/parametro/formapagamento/
    #   The list of payment methods on the Moip's official documentation
    PAYMENT_METHODS = {
      "BoletoBancario" => :payment_form,
      "CartaoDeCredito" => :credit_card,
      "DebitoBancario" => :debit,
      "CartaoDeDebito" => :debit_card,
      "FinanciamentoBancario" => :financing,
      "CarteiraMoIP" => :moip_account
    }

    attr_reader :params
    private :params

    def initialize(params)
      @params = params
    end

    # @return [String] informed unique identifier
    def id
      params["id_transacao"]
    end

    # @return [Float] amount paid by the user
    def price
      params["valor"].to_i / 100.0
    end

    # @return [Symbol] payment status
    # @see PAYMENT_STATUSES The full list of possible payment statuses
    #   returned
    def payment_status
      PAYMENT_STATUSES[params["status_pagamento"].to_i]
    end

    # @return [Integer] the internal Moip identifier for this transaction
    def moip_id
      params["cod_moip"].to_i
    end

    # @return [String] financial institution name
    # @see FINANCIAL_INSTITUTIONS The full list of possible financial
    #   institutions returned
    def financial_institution
      FINANCIAL_INSTITUTIONS[params["forma_pagamento"].to_i]
    end

    # @return [String] payment method used by this transaction
    # @see PAYMENT_METHODS The full list of possible payment
    #   method returned
    def payment_method
      PAYMENT_METHODS[params["tipo_pagamento"]]
    end

    # @return [Integer] number of quotas that the payment was
    #   divided
    def quotas
      params["parcelas"].to_i
    end

    # @return [String] user email address
    def user_email
      params["email_consumidor"]
    end

    # @return [String] additional information provided by the financial
    #   institution regarding this transaction when it has a canceled status
    # @see http://labs.moip.com.br/referencia/classificacao-de-cancelamento/
    #   The Moip's official documentation regarting payment cancelling
    def additional_info
      params["classificacao"]
    end
  end
end
