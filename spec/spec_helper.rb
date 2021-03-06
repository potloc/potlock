# frozen_string_literal: true

require "potlock"
require "mock_redis"
require "redlock/testing"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    Redlock::Client.testing_mode = :bypass

    redis_instance = MockRedis.new
    allow(Redis).to receive_message_chain(:new).and_return(redis_instance)
  end
end
