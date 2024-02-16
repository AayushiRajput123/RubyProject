# development
# Use an official Ruby runtime as the base image with the specific version
FROM ruby:3.2.2

# Set environment variables
ENV RAILS_ENV=development \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true

# Set working directory in the container
WORKDIR /usr/src/app

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    yarn \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install bundler and gems
RUN gem install bundler
RUN bundle install

# Copy the rest of the application code
COPY . .

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]


# production
# Use a minimal base image
# FROM ruby:3.2.2-alpine

# # Set environment variables
# ENV RAILS_ENV=production \
#     RAILS_LOG_TO_STDOUT=true \
#     RAILS_SERVE_STATIC_FILES=true

# # Set working directory in the container
# WORKDIR /usr/src/app

# # Install dependencies
# RUN apk add --no-cache \
#     build-base \
#     nodejs \
#     yarn \
#     sqlite-dev \
#     tzdata

# # Copy Gemfile and Gemfile.lock
# COPY Gemfile Gemfile.lock ./

# # Install bundler and gems
# RUN gem install bundler
# RUN bundle install --without development test

# # Copy the rest of the application code
# COPY . .

# # Precompile assets
# RUN bundle exec rails assets:precompile

# # Expose port 3000 to the outside world
# EXPOSE 3000

# # Start the Rails server
# CMD ["rails", "server", "-b", "0.0.0.0"]
