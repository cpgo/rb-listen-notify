FROM ruby:2.6.5-alpine

ENV APP_DIR=/app/
ENV BUILD_DEPS="curl tar wget linux-headers" \
    DEV_DEPS="build-base postgresql-dev zlib-dev libxml2-dev libxslt-dev readline-dev tzdata"

RUN apk add --update --upgrade $BUILD_DEPS $DEV_DEPS

COPY Gemfile* $APP_DIR

WORKDIR $APP_DIR/
RUN gem install bundler && bundle install

CMD ["ruby", "/app/app.rb"]