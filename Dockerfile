FROM ruby:1.9.3

RUN apt-get update \
    && apt-get install -y \
        build-essential \
        libv8-dev \
        locales \
    && locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN mkdir -p /app
WORKDIR /app

COPY vendor/kgs_scraper ./vendor/kgs_scraper
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "-b", "0.0.0.0", "-p", "3000"]
