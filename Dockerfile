FROM ruby:2.4-onbuild
RUN apt-get update
RUN apt-get install -y libmysqlclient-dev build-essential nodejs
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app
