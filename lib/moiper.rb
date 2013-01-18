require "moiper/version"

module Moiper
  class << self
    attr_accessor :token, :key

    def configure(&block)
      yield self
    end
  end
end
