# base image ruby 2.7.0
FROM ruby:2.7.0
ENV LANG C.UTF-8

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y \
    sudo \
    nodejs

# install gems
WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

# copy project files
ENV APP_HOME /code_chunk
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME