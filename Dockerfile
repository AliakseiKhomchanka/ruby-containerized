FROM ruby:alpine3.19
WORKDIR /usr/src/app
COPY http_server.rb .
EXPOSE 80
CMD ["ruby", "http_server.rb"]
