# Rename this file to deploy.rb

# Fill slice_url in - where you're installing your stack to
role :app, "0.0.0.0"

# Fill user in - if remote user is different to your local user
set :user, "rails"

default_run_options[:pty] = true
