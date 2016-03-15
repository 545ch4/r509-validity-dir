$:.push File.expand_path("../lib", __FILE__)
require "r509/validity/dir/version"

spec = Gem::Specification.new do |s|
  s.name = 'r509-validity-dir'
  s.version = R509::Validity::Dir::VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = false
  s.summary = "A Validity::Writer and Validity::Checker for r509, implemented with a OpenSSL directory backend"
  s.description = "A Validity::Writer and Validity::Checker for r509, implemented with a OpenSSL directory backend"
  s.add_dependency 'r509'
  s.add_dependency 'rake'
  s.author = "Sascha Willuweit"
  s.email = "s@rprojekt.org"
  s.required_ruby_version = ">= 1.9.3"
  s.files = %w(README.md Rakefile) + Dir["{lib}/**/*"]
  s.require_path = "lib"
end
