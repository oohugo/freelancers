FROM ruby:3.0.3-alpine
RUN apk -U add --no-cache \
 build-base \
 git \
 mysql-dev \
 mysql-client \
 libxml2-dev \
 libxslt-dev \
 nodejs \
 yarn \
 imagemagick \
 tzdata \
 less \
 bash \
 sqlite-dev\
 && rm -rf /var/cache/apk/*

WORKDIR /app
COPY . /app/
# COPY Gemfile /app/

RUN yarn install
RUN bundle install

# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
EXPOSE 3000
