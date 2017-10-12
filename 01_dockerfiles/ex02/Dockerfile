FROM ruby:latest

RUN apt-get upgrade && apt-get update
RUN gem install rails -v 5.1.4 && gem install bundler && gem install rake 

ONBUILD WORKDIR /opt/app

ONBUILD COPY app/ /opt/app

ONBUILD RUN bundle install
ONBUILD RUN rake db:migrate && rake db:seed

EXPOSE 3000
