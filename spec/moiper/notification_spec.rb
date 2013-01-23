require "spec_helper"

describe Moiper::Notification do
  let(:params) {
    {
      "id_transacao" => "abc.1234",
      "valor" => "50034",
      "status_pagamento" => "5",
      "cod_moip" => "12345678",
      "forma_pagamento" => "3",
      "tipo_pagamento" => "CartaoDeCredito",
      "parcelas" => "1",
      "email_consumidor" => "pagador@email.com.br",
      "classificacao" => "Solicitado pelo vendedor"
    }
  }

  # subject { Moiper::Notification.new(params) }
  subject { described_class.new(params) }

  its(:id) { should eq "abc.1234" }
  its(:price) { should eq 500.34 }
  its(:payment_status) { should eq :canceled }
  its(:moip_id) { should eq 12345678 }
  its(:financial_institution) { should eq "Visa" }
  its(:payment_method) { should eq :credit_card }
  its(:quotas) { should eq 1 }
  its(:user_email) { should eq "pagador@email.com.br" }
  its(:additional_info) { should eq "Solicitado pelo vendedor" }
end
