root = File.expand_path(File.expand_path(File.dirname(__FILE__)) + "/../")
working_directory root

pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.stderr.log"
stdout_path "#{root}/log/unicorn.stdout.log"

listen "/tmp/unicorn.coursehub.sock"
timeout 30
worker_processes 2

preload_app true

before_exec do |_|
  ENV['BUNDLE_GEMFILE'] = "#{root}/Gemfile"
end
