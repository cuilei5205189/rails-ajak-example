FROM ruby:2.6.3
LABEL maintainer="educative" 
RUN apt-get update -yqq && apt-get install -yqq nodejs npm && npm install -g yarn
WORKDIR /app
COPY ./Gemfile* /app
RUN bundle install && rails webpacker:install && bundle update
RUN rails db:setup && rails db:migrate
COPY ./ /app/
CMD ["bin/rails", "s", "-b", "0.0.0.0"] 
