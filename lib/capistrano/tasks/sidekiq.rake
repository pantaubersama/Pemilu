# For capistrano 3
namespace :sidekiq do
  task :quiet do
    on roles(:app) do
      puts capture("pgrep -f 'sidekiq' | xargs kill -TSTP")
    end
  end
  task :restart do
    on roles(:app) do
      execute :sudo, :systemctl, :restart, :sidekiq
    end
  end
end
