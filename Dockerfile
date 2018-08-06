FROM ruby

RUN mkdir /app
WORKDIR /app

RUN gem install \
    sinatra \
    sinatra-contrib

