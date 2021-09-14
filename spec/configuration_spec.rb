# frozen_string_literal: true

RSpec.describe Potlock::Configuration do
  subject { described_class.new }

  describe "redis_host" do
    context "when no redis_host is specified" do
      it "defaults to Redis hostname" do
        expect(subject.redis_host).to eq("localhost")
      end
    end

    context "when env DEFAULT_REDIS_HOST is specified" do
      before { ENV["DEFAULT_REDIS_HOST"] = "redis_node_1" }

      it "returns redis_node_1" do
        expect(subject.redis_host).to eq("redis_node_1")
      end
    end
  end

  describe "redis_port" do
    context "when no redis_port is specified" do
      it "defaults to Redis port" do
        expect(subject.redis_port).to eq("6379")
      end
    end

    context "when env DEFAULT_REDIS_PORT is specified" do
      before { ENV["DEFAULT_REDIS_PORT"] = "6380" }

      it "returns 6380" do
        expect(subject.redis_port).to eq("6380")
      end
    end
  end

  describe "redis_db" do
    context "when no redis_db is specified" do
      it "defaults to Redis database" do
        expect(subject.redis_db).to eq("1")
      end
    end

    context "when env DEFAULT_REDIS_DB is specified" do
      before { ENV["DEFAULT_REDIS_DB"] = "2" }

      it "returns 2" do
        expect(subject.redis_db).to eq("2")
      end
    end
  end

  describe "retry_count" do
    context "when no retry_count is specified" do
      it "defaults to retry count" do
        expect(subject.retry_count).to eq(25)
      end
    end
  end

  describe "retry_delay" do
    context "when no retry_delay is specified" do
      it "defaults to retry delay" do
        expect(subject.retry_delay).to eq(200)
      end
    end
  end
end
