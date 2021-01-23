FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /camp_app
WORKDIR /camp_app

COPY Gemfile /camp_app/Gemfile
COPY Gemfile.lock /camp_app/Gemfile.lock

RUN bundle install
COPY . /camp_app