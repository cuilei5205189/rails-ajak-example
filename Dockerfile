FROM ruby:2.6.3
RUN apt-get update -yqq && apt-get install -yqq nodejs npm && npm install -g yarn
WORKDIR /app
COPY ./Gemfile* /app
RUN bundle install && rails webpacker:install
COPY ./ /app/
CMD rails db:setup; rails s -b 0.0.0.0
