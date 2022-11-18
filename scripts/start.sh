# Gems Install
bundle check || bundle install

bundle exec yarn

# Run Foreman Server
rm -f tmp/pids/server.pid && bundle exec bin/dev
