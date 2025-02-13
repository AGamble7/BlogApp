# Use official Ruby image
FROM ruby:3.2.0

# Set working directory
WORKDIR /app

# Install dependencies
COPY Gemfile Gemfile.lock ./
RUN apt-get update && apt-get install --no-install-recommends -y build-essential git pkg-config libpq-dev \
    && gem install bundler:2.6.3
RUN bundler _2.6.3_ install

# Copy application files
COPY . .

# Expose port
EXPOSE 3000

# Start the Rails app
CMD ["rails", "server", "-b", "0.0.0.0"]
