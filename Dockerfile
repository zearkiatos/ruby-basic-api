FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /api
COPY Gemfile /api/Gemfile
COPY Gemfile.lock /api/Gemfile.lock
RUN bundle install
RUN gem install rake
COPY . /api

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

ENTRYPOINT ["build", "exec", "rake","db:setup"]

