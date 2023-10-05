# frozen_string_literal: true

require "mock_redis"

RSpec.describe Potlock do
  describe "#configure" do
    it "allows Potlock configuration" do
      Potlock.configure do |config|
        config.redis = MockRedis.new
        config.redis_host = "redis"
        config.redis_port = "6381"
        config.redis_db = "2"
        config.retry_count = 10
        config.retry_delay = 100
      end
      expect(Potlock.configuration.redis).to be_an_instance_of(MockRedis)
      expect(Potlock.configuration.redis_host).to eq("redis")
      expect(Potlock.configuration.redis_port).to eq("6381")
      expect(Potlock.configuration.redis_db).to eq("2")
      expect(Potlock.configuration.retry_count).to eq(10)
      expect(Potlock.configuration.retry_delay).to eq(100)
    end
  end
end
