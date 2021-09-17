FROM ruby:2.4.10

ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs \
    yarn \
 && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

ENV APP_HOME /myapp
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock
RUN bundle install

EXPOSE 3000

ADD . $APP_HOME
RUN RAILS_ENV=production bundle exec rails assets:precompile SECRET_KEY_BASE=dummysecret

CMD ["bash", "scripts/server.sh"]
