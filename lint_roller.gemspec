require_relative "lib/lint_roller/version"

Gem::Specification.new do |spec|
  spec.name = "lint_roller"
  spec.version = LintRoller::VERSION
  spec.authors = ["Justin Searls"]
  spec.email = ["searls@gmail.com"]

  spec.summary = "A plugin specification for linter and formatter rulesets"
  spec.homepage = "https://github.com/standardrb/lint_roller"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.require_paths = ["lib"]

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files = ["README.md", "LICENSE.txt", "CHANGELOG.md"]
  spec.test_files = Dir["test/**/*"]
end
