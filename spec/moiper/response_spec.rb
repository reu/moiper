# encoding: utf-8

require "spec_helper"

describe Moiper::Response do
  let(:success_response_fixture) {
    %Q{
    <?xml version="1.0"?>
      <ns1:EnviarInstrucaoUnicaResponse xmlns:ns1="http://www.moip.com.br/ws/alpha/">
        <Resposta>
          <ID>201301221539573040000001453849</ID>
          <Status>Sucesso</Status>
          <Token>M2M0J1D3M0U1L2L2S1W5V3X9T5V7Y3X0W4U0M0Z0L0G02001S4F513N8N4J9</Token>
        </Resposta>
      </ns1:EnviarInstrucaoUnicaResponse>
    }
  }

  let(:error_response_fixture) {
    %Q{
      <?xml version="1.0"?>
        <ns1:EnviarInstrucaoUnicaResponse xmlns:ns1="http://www.moip.com.br/ws/alpha/">
          <Resposta>
            <ID>201301221546325890000001453860</ID>
            <Status>Falha</Status>
            <Erro Codigo="101">A razão do pagamento deve ser enviada obrigatoriamente</Erro>
            <Erro Codigo="102">Id Próprio já foi utilizado em outra Instrução</Erro>
          </Resposta>
        </ns1:EnviarInstrucaoUnicaResponse>
    }
  }

  describe "#checkout_url" do
    context "when the response is success" do
      it "returns the url the user should be redirected" do
        response = Moiper::Response.new(success_response_fixture)
        response.checkout_url.should eq Moiper.api_entrypoint + "Instrucao.do?token=" + response.token
      end
    end

    context "when the response returns an error" do
      it "returns nil" do
        response = Moiper::Response.new(error_response_fixture)
        response.checkout_url.should be_nil
      end
    end
  end

  describe "#success?" do
    subject { Moiper::Response.new(body).success? }

    context "when the response is success" do
      let(:body) { success_response_fixture }
      it { should be_true }
    end

    context "when the response returns an error" do
      let(:body) { error_response_fixture }
      it { should be_false }
    end
  end

  describe "#errors" do
    context "when the response is success" do
      it "is an empty array" do
        Moiper::Response.new(success_response_fixture).errors.should be_empty
      end
    end

    context "when the response returns an error" do
      it "returns an array with errors" do
        errors = Moiper::Response.new(error_response_fixture).errors
        errors.should include "A razão do pagamento deve ser enviada obrigatoriamente"
        errors.should include "Id Próprio já foi utilizado em outra Instrução"
      end
    end
  end
end
