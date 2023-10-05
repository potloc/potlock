[![Potlock is released under the MIT license.](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![The code of conduct of Potlock.](https://img.shields.io/badge/Contributor%20Covenant-2.1-blue.svg)](CODE_OF_CONDUCT.md)
[![PRs welcome!](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![RSpec tests](https://github.com/potloc/potlock/actions/workflows/rspec.yml/badge.svg)](https://github.com/potloc/potlock/actions/workflows/rspec.yml)
[![Rubocop](https://github.com/potloc/potlock/actions/workflows/rubocop.yml/badge.svg)](https://github.com/potloc/potlock/actions/workflows/rubocop.yml)
[![Gem Version](https://badge.fury.io/rb/potlock.svg)](https://badge.fury.io/rb/potlock)

# Potlock - Distributed Read-Write lock using redis

Potlock is redis-based concurrent read-write lock distributed across processes.

Allows only one concurrent reader or writer. And if the lock is taken, any readers or writers who come along will have to wait.

Highly relying on https://github.com/leandromoreira/redlock-rb.

## Compatibility

Potlock works with Redis versions 2.6 or later.

## Getting started 🚀

Add this line to your application's Gemfile:

```ruby
gem "potlock"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install potlock

## Usage

### Initialize the lock

```ruby
redis_key = "hello_world" # The Redis key you want to read or write
lock = Potlock::Client.new(key: redis_key)
```
There's a list of options you can pass as described [here](#redis-client-configuration).

### Get a value from Redis

```ruby
# Will wait until all locks are freed before getting the key "hello_world".
value = lock.get
```

### Set a value on Redis

```ruby
lock.set do
  # Execute this block and set the return value in the key "hello_world"
end
```

### Fetch a value on Redis

```ruby
value = lock.fetch do
  # Fetch the key "hello_world" in Redis or execute this block if not present
end
```

### Errors handling

In case of the lock can't get acquired, an exception is raised:

```ruby
begin
  lock.set do
    # critical code
  end
rescue Potlock::LockError
  # error handling
end
```

### Redis client configuration

By default, `Potlock` will use Redis `redis://localhost:6379/1`. There's options you can use to change this default behaviour:

```ruby
Potlock.configure do |config|
  config.redis_host = "localhost"
  config.redis_port = "6379"
  config.redis_db   = "1"
  # or
  # config.redis = Redis.new(host: "localhost", port: 6379, db: 1)
end
```

### Potlock configuration

It's possible to customize the retry logic providing the following options:

```ruby
Potlock.configure do |config|
  config.retry_count = 25  # How many times it'll try to lock a resource
  config.retry_delay = 200 # How many milliseconds to sleep before try to lock again
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## How to Contribute 🤝

Bug reports and pull requests are welcome on GitHub at https://github.com/potloc/potlock. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/potloc/potlock/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Potlock project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/potloc/potlock/blob/main/CODE_OF_CONDUCT.md).
