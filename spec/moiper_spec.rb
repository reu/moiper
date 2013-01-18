require "moiper"

describe Moiper do
  describe ".configure" do
    it "yields Moiper" do
      Moiper.configure do |config|
        config.should be Moiper
      end
    end

    it "sets a token configuration" do
      Moiper.configure do |config|
        config.token = "Some Token"
      end

      Moiper.token.should eq "Some Token"
    end

    it "sets a key configuration" do
      Moiper.configure do |config|
        config.key = "Some Key"
      end

      Moiper.key.should eq "Some Key"
    end
  end

  describe ".sandbox?" do
    it "is false by default" do
      Moiper.sandbox?.should be_false
    end

    it "is true when you set sandbox configuration true" do
      Moiper.configure do |config|
        config.sandbox = true
      end

      Moiper.sandbox?.should be_true
    end

    it "is false when you set sandbox configuration to false" do
      Moiper.configure do |config|
        config.sandbox = false
      end

      Moiper.sandbox?.should be_false
    end
  end

  describe ".api_entrypoint" do
    subject { Moiper.api_entrypoint }

    it "is the sandbox url when sandbox is enabled" do
      Moiper.sandbox = true
      should == Moiper::API_ENTRYPOINTS[:sandbox]
    end

    it "is the production url when sandbox is disabled" do
      Moiper.sandbox = false
      should == Moiper::API_ENTRYPOINTS[:production]
    end
  end
end
