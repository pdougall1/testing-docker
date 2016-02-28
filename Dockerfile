FROM ruby:2.3.0
MAINTAINER Patrick Dougall <pdougall1@gmail.com>

ENV RACK_ENV=production
ENV RAILS_ENV=production

RUN apt-get update && apt-get install -y \
    nodejs \
    postgresql-client \
  --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install --without test development

COPY . .
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
