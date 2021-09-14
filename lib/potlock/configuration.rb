# frozen_string_literal: true

module Potlock
  class Configuration
    # Redis connection information
    attr_accessor :redis_host, :redis_port, :redis_db

    # How many times it'll try to lock a resource
    attr_accessor :retry_count

    # How many milliseconds to sleep before try to lock again
    attr_accessor :retry_delay

    def initialize
      @redis_host = ENV["DEFAULT_REDIS_HOST"] || "localhost"
      @redis_port = ENV["DEFAULT_REDIS_PORT"] || "6379"
      @redis_db   = ENV["DEFAULT_REDIS_DB"]   || "1"

      @retry_count = 25
      @retry_delay = 200
    end
  end
end
