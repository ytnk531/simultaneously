FROM simulteneously:1.0.0

ENV RAILS_ENV="production"
ENV NODE_ENV="production"

COPY ../ /app 
RUN bundle install --deployment --without test development
RUN bundle exec rails assets:precompile \
 && yarn cache clean \
 && rm -rf node_modules tmp/cache
CMD [ "bin/rails", "s", "-b", "0.0.0.0"]