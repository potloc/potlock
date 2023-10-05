# frozen_string_literal: true

RSpec.describe Potlock::Configuration do
  subject { described_class.new }

  describe "redis" do
    context "when no redis is specified" do
      it "defaults to nil" do
        expect(subject.redis).to be_nil
      end
    end
  end

  describe "redis_host" do
    context "when no redis_host is specified" do
      it "defaults to Redis hostname" do
        expect(subject.redis_host).to eq("localhost")
      end
    end
  end

  describe "redis_port" do
    context "when no redis_port is specified" do
      it "defaults to Redis port" do
        expect(subject.redis_port).to eq("6379")
      end
    end
  end

  describe "redis_db" do
    context "when no redis_db is specified" do
      it "defaults to Redis database" do
        expect(subject.redis_db).to eq("1")
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
