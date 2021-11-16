# frozen_string_literal: true

RSpec.describe Potlock::Client do
  subject { described_class.new(key: key) }

  let(:key) { "redis_key" }
  let(:redis) { subject.send("redis") }

  # Clean test key before each test
  before { redis.del(key) }

  describe "#fetch" do
    context "given a free lock" do
      context "given an existing value in Redis" do
        before { redis.set(key, "OLD_RESPONSE") }

        it "returns value from redis" do
          expect(subject.fetch { "RESPONSE" }).to eq("OLD_RESPONSE")
        end
      end

      context "given no value in Redis" do
        it "returns response from block execution" do
          expect(subject.fetch { "RESPONSE" }).to eq("RESPONSE")
        end

        it "stores the value in Redis" do
          expect(redis.get(key)).to be_nil
          subject.fetch { "RESPONSE" }
          expect(redis.get(key)).to eq("RESPONSE")
        end
      end
    end

    context "given a locked key" do
      before { Redlock::Client.testing_mode = :fail }

      it "raises an error" do
        expect do
          expect(redis.get(key)).to be_nil
          subject.fetch { "RESPONSE" }
          expect(redis.get(key)).to be_nil
        end.to raise_error(Potlock::LockError)
      end
    end
  end

  describe "#get" do
    context "given a free lock" do
      it "gets value from Redis" do
        redis.set(key, "RESPONSE")
        expect(subject.get).to eq("RESPONSE")
      end
    end

    context "given a locked key" do
      before { Redlock::Client.testing_mode = :fail }

      it "raises an error" do
        expect do
          subject.get
        end.to raise_error(Potlock::LockError)
      end
    end
  end

  describe "#set" do
    it "returns the passed value" do
      expect(subject.set { "RESPONSE" }).to eq("RESPONSE")
    end

    context "given a free lock" do
      it "stores value in Redis" do
        expect(redis.get(key)).to be_nil
        subject.set { "RESPONSE" }
        expect(redis.get(key)).to eq("RESPONSE")
      end
    end

    context "given a locked key" do
      before { Redlock::Client.testing_mode = :fail }

      it "raises an error" do
        expect(redis.get(key)).to be_nil
        expect do
          subject.set { "RESPONSE" }
        end.to raise_error(Potlock::LockError)
        expect(redis.get(key)).to be_nil
      end
    end
  end
end
