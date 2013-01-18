require "moiper"

describe Moiper do
  describe "configure" do
    it "yields Moiper" do
      Moiper.configure do |config|
        config.should == Moiper
      end
    end

    it "sets a token configuration" do
      Moiper.configure do |config|
        config.token = "Some Token"
      end

      Moiper.token.should == "Some Token"
    end

    it "sets a key configuration" do
      Moiper.configure do |config|
        config.key = "Some Key"
      end

      Moiper.key.should == "Some Key"
    end
  end
end
