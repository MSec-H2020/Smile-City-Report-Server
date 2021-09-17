FROM ruby:2.4.10

ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs \
    yarn \
 && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock
RUN bundle install

EXPOSE 3000

ADD . $APP_HOME

ENTRYPOINT ["bundle", "exec", "rails"]
