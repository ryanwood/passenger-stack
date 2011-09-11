package :rbenv, :provides => :ruby_versioning do
  description 'rbenv: Simple Ruby Version Management'

  noop do
    pre :install, %Q[ git clone git@github.com:sstephenson/rbenv.git ~/.rbenv ]
    pre :install, %Q[ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile ]
    pre :install, %Q[ echo 'eval "$(rbenv init -)"' >> .bash_profile ]
    pre :install, %Q[ exec ]
  end

  verify do
    has_executable 'rbenv'
  end

  requires :scm
end

package :ruby_build do
  description 'ruby-build'

  noop do
    pre :install, %Q[ cd ~ && git clone git@github.com:sstephenson/ruby-build.git ]
    pre :install, %Q[ cd ruby-build && ./install.sh ]
  end

  verify do
    has_executable 'ruby-build'
  end

  requires :rbenv
end

package :ruby_enterprise do
  noop do
    pre :install, %Q[ ruby-build ree-1.8.7-2011.03 ~/.rbenv/versions/ree-1.8.7-2011.03 ]
    pre :install, %Q[ rbenv rehash ]
    pre :install, %Q[ rbenv set-default ree-1.8.7-2011.03 ]
  end

  verify { has_executable 'ruby' }

  requires :ree_dependencies
  requires :ruby_build
end

package :bundler do
  gem "bundler" do
    post :install, 'rbenv rehash'
  end

  verify { has_gem 'bundler' }
  requires :ruby_build
end

package :ree_dependencies do
  apt %w(zlib1g-dev libreadline5-dev libssl-dev)
  requires :build_essential
end
