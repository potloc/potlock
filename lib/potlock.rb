# frozen_string_literal: true

require "redis"
require "redlock"

require_relative "potlock/client"
require_relative "potlock/configuration"
require_relative "potlock/version"

module Potlock
  class LockError < StandardError; end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
