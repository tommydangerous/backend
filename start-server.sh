#!/bin/bash -x
cd $ROOT_DIR
bundle exec unicorn -E $RAILS_ENV -p 8080 -c config/unicorn.rb
