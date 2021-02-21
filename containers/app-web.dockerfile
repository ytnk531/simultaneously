FROM simultaneously:latest

ENV RAILS_ENV="production"
ENV NODE_ENV="production"
ENV

COPY . /app
RUN bundle install --deployment --without test development
RUN SECRET_KEY_BASE="secret_key_base" bundle exec rails assets:precompile \
 && yarn cache clean \
 && rm -rf node_modules tmp/cache
CMD [ "bin/rails", "s", "-b", "0.0.0.0"]
