module Moiper
  class Notification
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

    def id
      params["id_transacao"]
    end

    def price
      params["valor"].to_i / 100.0
    end

    def payment_status
      PAYMENT_STATUSES[params["status_pagamento"].to_i]
    end

    def moip_id
      params["cod_moip"].to_i
    end

    def financial_institution
      FINANCIAL_INSTITUTIONS[params["forma_pagamento"].to_i]
    end

    def payment_method
      PAYMENT_METHODS[params["tipo_pagamento"]]
    end

    def quotas
      params["parcelas"].to_i
    end

    def user_email
      params["email_consumidor"]
    end

    def additional_info
      params["classificacao"]
    end
  end
end
