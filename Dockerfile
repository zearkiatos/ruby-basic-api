FROM ruby:2.6.3-alpine

RUN apk update && apk --no-cache --update add build-base postgresql-dev imagemagick xvfb qt5-qtbase qt5-qtbase-dev gst-plugins-base gstreamer-tools gstreamer curl tzdata

RUN apk add --update nodejs npm
RUN apk add --update yarn

RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN gem install bundle
RUN bundle update --bundler
RUN bundle install
ADD . /app
ENTRYPOINT ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]


# COPY ./docker/entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh

# Install capybara-webkit deps
# RUN apt-get update \
#     && apt-get install -y build-essential libpq-dev imagemagick xvfb qt5-default libqt5webkit5-dev \
#                           gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x

# # Node.js
# RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - \
#     && apt-get install -y nodejs

# # yarn
# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
#     && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
#     && apt-get update \
#     && apt-get install -y yarn

# RUN mkdir /app
# WORKDIR /app
# ADD Gemfile /app/Gemfile
# ADD Gemfile.lock /app/Gemfile.lock
# RUN gem install bundle
# RUN bundle update --bundler
# RUN bundle install
# ADD . /app

# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
