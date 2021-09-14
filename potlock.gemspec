# frozen_string_literal: true

require_relative "lib/potlock/version"

Gem::Specification.new do |spec|
  spec.name          = "potlock"
  spec.version       = Potlock::VERSION
  spec.authors       = ["Thibault Couraud"]
  spec.email         = ["thibault.couraud@potloc.com"]

  spec.summary       = "Distributed Read-Write lock using redis."
  spec.description   = "Potlock is redis based concurrent read-write lock distributed across processes."
  spec.homepage      = "https://github.com/POTLOC/potlock"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
    spec.metadata["changelog_uri"] = spec.homepage
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "redlock", "~> 1.2"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop-rspec", "~> 2.4"
end
