# frozen_string_literal: true

module Potlock
  class Client
    attr_accessor :key, :lock_key

    def initialize(key:)
      @key = key
      @lock_key = "#{key}_lock"
    end

    def fetch
      lock! do
        return redis.get(key) if redis.exists?(key)

        value = yield
        redis.set(key, value)
        value
      end
    rescue Redlock::LockError => _e
      raise Potlock::LockError
    end

    def get
      lock! { redis.get(key) }
    rescue Redlock::LockError => _e
      raise Potlock::LockError
    end

    def set(&block)
      value = lock!(&block)
      redis.set(key, value)
      value
    rescue Redlock::LockError => _e
      raise Potlock::LockError
    end

    private

    def lock!(&block)
      lock_manager.lock!(lock_key, retry_delay, &block)
    end

    def lock_manager
      @lock_manager ||= Redlock::Client.new(
        [
          redis,
        ],
        {
          retry_count: Potlock.configuration.retry_count,
          retry_delay: Potlock.configuration.retry_delay,
        },
      )
    end

    def retry_delay
      Potlock.configuration.retry_delay * Potlock.configuration.retry_count
    end

    def redis
      @redis ||= Redis.new(
        host: Potlock.configuration.redis_host,
        db: Potlock.configuration.redis_db,
        port: Potlock.configuration.redis_port,
      )
    end
  end
end
