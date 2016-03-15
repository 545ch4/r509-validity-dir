require 'rubygems'
require "#{File.dirname(__FILE__)}/lib/r509/validity/dir/version"

namespace :gem do
    desc 'Build the gem'
    task :build do
        puts `yard`
        puts `gem build r509-validity-dir.gemspec`
    end

    desc 'Install gem'
    task :install do
        puts `gem install r509-validity-dir-#{R509::Validity::Redis::VERSION}.gem`
    end

    desc 'Uninstall gem'
    task :uninstall do
        puts `gem uninstall r509-validity-dir`
    end
end

desc 'Build yard documentation'
task :yard do
	puts `yard`
	`open doc/index.html`
end
