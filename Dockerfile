FROM ruby:2.4.1-alpine

RUN apk --update add nodejs netcat-openbsd postgresql-dev
RUN apk --update add --virtual build-dependencies make g++

ENV INSTALL_PATH /shopify_marketplace_api
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install
RUN apk del build-dependencies && rm -rf /var/cache/apk/*

COPY . .

CMD bundle exec puma -C config/puma.rb