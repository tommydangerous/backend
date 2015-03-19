app_name = ENV["APP_NAME"]

app_dir    = File.expand_path "../../", __FILE__
# shared_dir = File.expand_path "../../../shared/", __FILE__

working_directory app_dir

worker_processes 3
preload_app true # Load the app into master before forking workers
timeout 30 # Restart any workers that haven't responded in 30 seconds

stderr_path "#{app_dir}/log/unicorn.log"
stdout_path "#{app_dir}/log/unicorn.log"

# Listen on a Unix data socket
listen "#{app_dir}/tmp/sockets/unicorn.sock", backlog: 64
# listen "127.0.0.1:8080"

# pid "#{app_dir}/tmp/pids/unicorn.pid"

before_exec do |server|
  # ENV["BUNDLE_GEMFILE"] = "#{app_dir}/Gemfile"
  ENV["BUNDLE_GEMFILE"] = "/var/www/#{app_name}/current/Gemfile"
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      # decrement worker count of old master
      # until final new worker starts, then kill old master
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  # Unicorn master loads the app then forks off workers - because of the way
  # Unit forking works, we need to make sure we aren't using any of the parent's
  # sockets, e.g. db connection
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
