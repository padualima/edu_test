# Gems Install
bundle check || bundle install
# Run servidor
bundle exec puma -C config/puma.rb
