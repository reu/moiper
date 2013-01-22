require "spec_helper"

describe Moiper::Request do
  describe "#process" do
    it "returns a Response object" do
      response = Moiper::Request.new.process("<someXml></someXml>")
      response.should be_kind_of Moiper::Response
    end
  end

  describe "#client" do
    let(:client) { Moiper::Request.new.client }

    it "uses SSL" do
      client.use_ssl?.should be_true
    end

    it "verifies the certificate" do
      client.verify_mode.should == OpenSSL::SSL::VERIFY_PEER
    end

    it "uses the right ca file" do
      client.ca_file.should == Moiper::Request::CA_FILE
    end
  end

  describe "#request" do
    subject { Moiper::Request.new.request }
    its(:content_type) { should eq "text/xml" }

    it "sets the correct token and key parameters" do
      Net::HTTP::Post.any_instance.should_receive(:basic_auth).with(Moiper.token, Moiper.key)
      Moiper::Request.new.request
    end

    it "has the correct user agent" do
      headers = Hash[subject.each_capitalized.to_a]
      headers["User-Agent"].should eq "Moiper/#{Moiper::VERSION}"
    end
  end
end
