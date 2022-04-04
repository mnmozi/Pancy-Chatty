FROM ruby:3.0-slim

RUN apt-get update -qq \
    && apt-get install -y \
    build-essential \
    nodejs \
    default-libmysqlclient-dev \
    libpq-dev

RUN groupadd --gid 1000 ruby \
    && useradd --uid 1000 --gid ruby --shell /bin/bash --create-home ruby

WORKDIR /ruby

COPY Gemfile Gemfile.lock ./ 
RUN chown -R ruby:ruby .

USER ruby

RUN bundle install 

COPY --chown=ruby:ruby . .

EXPOSE 3000