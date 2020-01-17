FROM ruby:2.6.3

ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential software-properties-common

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

RUN curl https://cli-assets.heroku.com/install.sh | sh

ENV APP_HOME /app

ENV PATH="/usr/local/bin:${PATH}"

RUN mkdir $APP_HOME
WORKDIR $APP_HOME


ADD . $APP_HOME

RUN echo $(ls bin)
RUN chmod +x bin/setup
RUN chmod +x bin/setup_heroku

CMD ["./bin/setup",bundle exec rails s -p 3000 -b '0.0.0.0'"]