FROM ruby:2.3.1
MAINTAINER Szymon Miedziejko <miedziejko@gmail.com>

RUN apt-get update -qq && apt-get install -y build-essential

# Install gems
ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY . $APP_HOME

# Start server
EXPOSE 4000
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "4000"]
