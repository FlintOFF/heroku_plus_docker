FROM ruby:2.6.6
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs && gem install bundler:2.1.4
# Set an environment variable where the Rails app is installed to inside of Docker image
ENV RAILS_ROOT /var/www/rails_app
RUN mkdir -p $RAILS_ROOT
# Set working directory
WORKDIR $RAILS_ROOT
# Setting env up
ENV RAILS_ENV='production'
ENV RACK_ENV='production'
# Adding gems
COPY rails_app/Gemfile Gemfile
COPY rails_app/Gemfile.lock Gemfile.lock
RUN bundle install --jobs 20 --retry 5 --without development test
# Adding project files
COPY ./rails_app .
#RUN bundle exec rake assets:precompile
EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]