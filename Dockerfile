# Use an official Ruby runtime as the base image
FROM ruby:3.0.0

# Set the working directory in the container
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    sqlite3 \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Install Rails
RUN gem install rails

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install bundle of gems
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the Rails server when the container starts
CMD ["rails", "server", "-b", "0.0.0.0"]
