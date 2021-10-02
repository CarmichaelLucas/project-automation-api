FROM ruby:alpine3.14

RUN apk add --no-cache --update \ 
            build-base
            
RUN gem update --system \
    && gem install bundler 

WORKDIR /test

COPY Gemfile .
COPY /test .

RUN bundle install