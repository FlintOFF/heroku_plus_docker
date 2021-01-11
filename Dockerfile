FROM ruby:2.6.6
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs nginx apache2-utils && gem install bundler:2.1.4

ENV VUEJS_APP1_ROOT /var/www/vuejs_app1
RUN mkdir -p $VUEJS_APP1_ROOT
COPY vuejs_app1 $VUEJS_APP1_ROOT

ENV VUEJS_APP2_ROOT /var/www/vuejs_app2
RUN mkdir -p $VUEJS_APP2_ROOT
COPY vuejs_app2 $VUEJS_APP2_ROOT

# Set an environment variable where the Rails app is installed to inside of Docker image
ENV RAILS_ROOT /var/www/rails_app
RUN mkdir -p $RAILS_ROOT
RUN git clone https://github.com/heroku/ruby-getting-started.git $RAILS_ROOT

COPY docker/nginx/nginx.conf /etc/nginx/sites-enabled/default.conf
RUN service nginx restart

# Set working directory
WORKDIR $RAILS_ROOT
# Setting env up
ENV RAILS_ENV='development'
ENV RACK_ENV='development'
# Install GEMS
RUN bundle install --jobs 20 --retry 5
