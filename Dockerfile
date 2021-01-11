FROM ruby:2.6.6
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs && gem install bundler:2.1.4
# Set an environment variable where the Rails app is installed to inside of Docker image
ENV RAILS_ROOT /rails_app
RUN mkdir -p $RAILS_ROOT
RUN git clone https://github.com/heroku/ruby-getting-started.git $RAILS_ROOT

# Set working directory
WORKDIR $RAILS_ROOT
# Setting env up
ENV RAILS_ENV='development'
ENV RACK_ENV='development'
# Install GEMS
RUN bundle install --jobs 20 --retry 5
