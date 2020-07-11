FROM gcr.io/hale-sentry-267012/ruby@sha256:b9c2ec487718d00f592675c95867fe6d38e994b561e74efd60212c58a11da130

WORKDIR /app/sports
COPY ./Gemfile* ./
RUN bundle install --deployment --without development test
COPY . /app/sports
RUN bundle exec whenever --update-crontab
RUN mkdir -p tmp/pids

EXPOSE 3000

CMD ["bin/setup"]
