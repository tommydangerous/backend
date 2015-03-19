FROM ruby

ENV RAILS_ENV production
ENV ROOT_DIR /var/www/app

RUN mkdir -p $ROOT_DIR
WORKDIR $ROOT_DIR
# Mount volume for Nginx to serve static files from public folder
VOLUME $ROOT_DIR

# Gems
COPY Gemfile $ROOT_DIR/
COPY Gemfile.lock $ROOT_DIR/
RUN bundle install --system

# Add all files
COPY . $ROOT_DIR

# Assets
# RUN bundle exec rake assets:precompile assets:clean RAILS_ENV=$RAILS_ENV --trace

COPY start-server.sh /usr/bin/start-server.sh
RUN chmod +x /usr/bin/start-server.sh

# RUN mkdir -p $SHARED_DIR/log
# RUN mkdir -p $SHARED_DIR/pids
# RUN chmod +w $SHARED_DIR/log
# RUN chmod +w $SHARED_DIR/pids

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Secrets
ENV SECRET_KEY_BASE c90e9947c70d305956c782fd689d67ee3b53d438a98e570a70e1765ecf3b697b3ae0dcdb1545707eb9b7c3f573abc0aeadc1023bdcd7b17491f3947459d16612

ENV DB_NAME quantum

EXPOSE 8080

CMD /usr/bin/start-server.sh
