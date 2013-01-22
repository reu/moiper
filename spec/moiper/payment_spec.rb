require "spec_helper"

describe Moiper::Payment do
  describe "#initialize" do
    subject {
      Moiper::Payment.new(
        :description      => "A chair",
        :price            => 1.99,
        :id               => "some unique id",
        :return_url       => "http://example.org/thank_you",
        :notification_url => "http://example.org/moip/notification"
      )
    }

    its(:description) { should eq "A chair" }
    its(:price)       { should == 1.99 }
    its(:id)          { should eq "some unique id" }
    its(:return_url)  { should eq "http://example.org/thank_you"}
    its(:notification_url) { should eq "http://example.org/moip/notification" }

    it "raises an error when no description is given" do
      expect {
        Moiper::Payment.new(
          :price            => 1.99,
          :id               => "some unique id",
          :return_url       => "http://example.org/thank_you",
          :notification_url => "http://example.org/moip/notification"
        )
      }.to raise_error ArgumentError
    end

    it "raises an error when a blank description is given" do
      expect {
        Moiper::Payment.new(
          :description      => "",
          :price            => 1.99,
          :id               => "some unique id",
          :return_url       => "http://example.org/thank_you",
          :notification_url => "http://example.org/moip/notification"
        )
      }.to raise_error ArgumentError
    end

    it "raises an error when no price is given" do
      expect {
        Moiper::Payment.new(
          :description      => "Some description",
          :id               => "some unique id",
          :return_url       => "http://example.org/thank_you",
          :notification_url => "http://example.org/moip/notification"
        )
      }.to raise_error ArgumentError
    end

    it "raises an error when the price is zero" do
      expect {
        Moiper::Payment.new(
          :description      => "Some description",
          :price            => 0,
          :id               => "some unique id",
          :return_url       => "http://example.org/thank_you",
          :notification_url => "http://example.org/moip/notification"
        )
      }.to raise_error ArgumentError
    end

    it "raises an error when the price is lower than zero" do
      expect {
        Moiper::Payment.new(
          :description      => "Some description",
          :price            => -10,
          :id               => "some unique id",
          :return_url       => "http://example.org/thank_you",
          :notification_url => "http://example.org/moip/notification"
        )
      }.to raise_error ArgumentError
    end
  end

  describe "#to_xml" do
    let(:payment) {
      Moiper::Payment.new(
        :description      => "A chair",
        :price            => 1.99,
        :id               => "some unique id",
        :return_url       => "http://example.org/thank_you",
        :notification_url => "http://example.org/moip/notification"
      )
    }

    let(:doc) { Nokogiri::XML(payment.to_xml) }

    it { doc.at_css("> EnviarInstrucao").should_not be_nil }
    it { doc.at_css("EnviarInstrucao > InstrucaoUnica").should_not be_nil }
    it { doc.at_css("InstrucaoUnica > IdProprio").should_not be_nil }
    it { doc.at_css("InstrucaoUnica > Valores").should_not be_nil }
    it { doc.at_css("Valores > Valor").should_not be_nil }
    it { doc.at_css("InstrucaoUnica > URLRetorno").should_not be_nil }
    it { doc.at_css("InstrucaoUnica > URLNotificacao").should_not be_nil }

    it { doc.at_css("InstrucaoUnica > IdProprio").text.should eq "some unique id"}
    it { doc.at_css("Valores > Valor").text.should eq "1.99"}
    it { doc.at_css("Valores > Valor").attributes["moeda"].value.should eq "BRL"}

    it { doc.at_css("InstrucaoUnica > URLRetorno").text.should eq "http://example.org/thank_you" }
    it { doc.at_css("InstrucaoUnica > URLNotificacao").text.should eq "http://example.org/moip/notification" }
  end
end
